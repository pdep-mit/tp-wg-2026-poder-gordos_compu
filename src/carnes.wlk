import wollok.game.*
import asador.*
import barrasAviso.*
import animaciones.*
import estadoCarne.*
import itemFrame.*
//super clase carne abstracta 
class Carne {
  //el tiempo que pasa en la parrilla en puntos de coccion 
  var tiempoParrilla = 0 
  
  //pasa a ser un metodo sin cuerpo
  method tiempoCoccion()
  
  //sirve para armar la imagen de la carne
  method nombre()

  //creamos la barra de progreso de la carne 
  const barraProgreso = new BarraProgreso() 

  //el estado de la carne
  var estado = crudo
  
  //metodos y variables necesarias para ser agarrado por el asador
  var property portador = sinPortador
  var property posicionInicial = game.at(5,5)

  //deberia preguntarle al asador para donde esta mirando y luego devolver la posicion uno mas arriba, abajo, a la izquierda o derecha
  //pero primero deberia de tener una posicion inicial de donde saca la carne, le deberia pregunar rambien al coso que suministra la carne a ver donde esta
  //lo ultimo en caso de que no lo hayan agarrado 
  /*method calcularPosicion(){
    
  }*/

  //seria el tiempo (o puntos de coccion) que le damos de chance para que evite que se queme -- maybe abstracto
  method tiempoDeOnda() = 4

  //es el rango q le damos al jugador para hasta que la carne se queme
  method limiteDeQuemado() = self.tiempoCoccion() + self.tiempoDeOnda()

  //la imagen se calcula a partir del estado de la carne
  method image() = self.nombre() + "_" + estado.estado() + ".png"

  //da 4 puntos de coccion de chance para que la vayas a sacar 
  method seQuemo() = tiempoParrilla > self.limiteDeQuemado()

  //indica si la carne esta dentro del rango de "cocida"
  method estaCocida()  = tiempoParrilla.between(self.tiempoCoccion(), self.limiteDeQuemado())

  method cocinar(calor) {
    tiempoParrilla += calor
    estado = estado.siguienteEstado(self)
  }

  //regla de tres simple para el porcentaje de la carne a ver como se encuentra
  //tiempoCoccion -> 100%
  //tiempoParrilla -> x 
  method comoAndas() = (tiempoParrilla * 100) / self.tiempoCoccion()

  method enLaParrilla(){
    barraProgreso.carneActual(self)
    game.addVisual(barraProgreso)
  }

  method fueraDeParrilla() {
    game.removeVisual(barraProgreso)
  } 

  
  //revisar 
  method esCarne() = true

  //revisar ...

  method position() = 
    if(portador.esPortador()){
      portador.posicionDeLoQueLlevo()
    } else {
      posicionInicial
    }
  
  method llevadoPor(algo){
    if (!game.hasVisual(itemFrame)) game.addVisual(itemFrame) // <--- solo lo agrega si no estaba
      portador.dejarDeLlevar(algo)
      portador = algo
  }
  method soltar() {
      if (game.hasVisual(itemFrame)) game.removeVisual(itemFrame) // <-- Remueve el frame
      posicionInicial = self.position()
      portador = sinPortador
  }
    
  // metodo para entregar el plato al comensal -- creo q deberia estar en asador
  method entregarA(comensal) {
      comensal.recibirPedido(self)
  } 
} 



class Asado inherits Carne {
  override method tiempoCoccion() = 16
  override method nombre() = "asado"
  
}



class Vacio inherits Carne {
  
}

class Lomo inherits Carne {
  
}

class Chorizo inherits Carne {
  override method tiempoCoccion() = 12
  override method nombre() = "chori"

  //al tener animacion -- si hacemos asado cocido con animacion tmb lo tenemos q hacer
  override method image() {
    if(self.estaCocida()) {
      return "chori_cocido_" + animaciones.siguienteFrame(8) + ".png"
    }   
    //cosas de herencia cheta
    return super()
  }
}

class Morcilla inherits Carne{
  const property nombre = "morcilla"
}

//esto es lo que explico la profe que esta re piola para poner el objeto vacio 
object noCarne {
  method cocinar(calor){}
  method comoAndas() = 0
  method seQuemo() = false
  method enLaParrilla(){}
  method fueraDeParrilla(){}
  method esCarne() = false
}