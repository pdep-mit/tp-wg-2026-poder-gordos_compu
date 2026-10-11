import wollok.game.*
import asador.*
import barrasAviso.*
import animaciones.*

//super clase carne
class Carne {
  //el tiempo que pasa en la parrilla en puntos de coccion 
  var tiempoParrilla = 0 
  const tiempoCoccion = 16 
  //delegar a un objeto animacion 
  var imagenActual = "asado_crudo.png"

  //creamos la barra de progreso de la carne 
  const barraProgreso = new BarraProgreso() 

  //cocido luego podria pasar a ser un estadoCarne que tenga la referencia a un objeto que sean los diferentes estados (crudo, jugoso, cocido, etc), vinculado a la barra de progreso
  var cocido = false
  //la posicion de la carne va a depender de la posicion del asador
  
  //metodos y variables necesarias para ser agarrado por el asador
  var property portador = sinPortador
  var property posicionInicial = game.at(5,5)

  //deberia preguntarle al asador para donde esta mirando y luego devolver la posicion uno mas arriba, abajo, a la izquierda o derecha
  //pero primero deberia de tener una posicion inicial de donde saca la carne, le deberia pregunar rambien al coso que suministra la carne a ver donde esta
  //lo ultimo en caso de que no lo hayan agarrado 
  /*method calcularPosicion(){
    
  }*/

  //esto de las imagenes seguro que se puede mejorar -- preguntar en clase jeje


  //seria el tiempo (o puntos de coccion) que le damos de chance para que evite que se queme 
  method tiempoDeOnda() = 4

  method image() = imagenActual

  method imagenCocida() {    
   if(cocido){
    imagenActual = "imagen de la carne cocida"
    }
  }

  method imagenQuemada() {
    imagenActual = "imagen de la carne quemada"
  }

  //da 4 puntos de coccion de chance para que la vayas a sacar (si el fuego esta fuerte seria un solo segundo - tal vez hay que dar un poco mas)
  method seQuemo() = tiempoParrilla > tiempoCoccion + self.tiempoDeOnda()

  method cocinar(calor) {
    tiempoParrilla += calor

    if(tiempoParrilla >= tiempoCoccion) {
      cocido = true
      self.imagenCocida()
      //deberia de avisar que se cocino y dar una alerta para que no c queme 
      //podemos generar una nueva instancia de alerta, en la posicion que tenga la carne en ese momento 
    }
    if(self.seQuemo()){
      self.imagenQuemada()
      //podriamos a hacer que muestre una barra de que se quemo
      //luego podriamos poner la imagen de la parrilla que sea quemada o que se prenda fuego 
    }
  }

  //regla de tres simple para el porcentaje de la carne a ver como se encuentra
  //tiempoCoccion -> 100%
  //tiempoParrilla -> x 
  method comoAndas() = (tiempoParrilla * 100) / tiempoCoccion

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
      portador = algo
  }
  method soltar() {
      posicionInicial = self.position()
      portador = sinPortador
  }
    
  // metodo para entregar el plato al comensal
  method entregarA(comensal) {
      comensal.recibirPedido(self)
  } 
} 



class Asado inherits Carne {

}



class Vacio inherits Carne {
  const property nombre = "vacio"
}

class Lomo inherits Carne {
  const property nombre = "lomo"
}

class Chorizo {
    var property posicionInicial = game.at(3,3) 
    var property portador = sinPortador 
    const property nombre = "chori" 
    

    // esto del contador es temporal -- unicamente para ver la animacion del chori cocido
    
    method imagenActual() = "chori_cocido_" + animaciones.siguienteFrame(8) + ".png"

    method image() = self.imagenActual()
    // volvimos a la posicion un metodo para que siempre valide y actualice su ubicacion a medida que se mueve su portador
    // soltar lo desvincula y actualiza su ubicacion inicial a la actual
    method position() = 
    if(portador.esPortador()){
      portador.posicionDeLoQueLlevo()
    } else {
      posicionInicial
    }
         
      
    method llevadoPor(algo){
      portador = algo
    }
    method soltar() {
      posicionInicial = self.position()
      portador = sinPortador
    }
    
    method cortar() {
      
    }

   

    method esCarne() = true
}

class Morcilla {
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