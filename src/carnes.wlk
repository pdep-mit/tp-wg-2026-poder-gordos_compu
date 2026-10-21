import wollok.game.*
import asador.*
import barrasAviso.*
import animaciones.*
import estadoCarne.*
import itemFrame.*
import items.*
import platos.*

//super clase carne abstracta 
class Carne inherits ElementoAgarrable {
  method esCarne() = true

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

  //seria el tiempo (o puntos de coccion) que le damos de chance para que evite que se queme -- maybe abstracto
  method tiempoDeOnda() = 4

  //es el rango q le damos al jugador para hasta que la carne se queme
  method limiteDeQuemado() = self.tiempoCoccion() + self.tiempoDeOnda()

  //la imagen se calcula a partir del estado de la carne 
  //aca hay polimorfismo
  method image() = self.nombre() + "_" + estado.estado() + ".png"

  //da 4 puntos de coccion de chance para que la vayas a sacar 
  method seQuemo() = tiempoParrilla > self.limiteDeQuemado()
  
  //indica si la carne esta dentro del rango de "cocida"
  method estaCocida() = tiempoParrilla.between(self.tiempoCoccion(), self.limiteDeQuemado())

  method seEstaPorQuemar() = tiempoParrilla.between(self.tiempoCoccion() + 2, self.limiteDeQuemado())

  method cocinar(calor) {
    tiempoParrilla += calor
    estado = estado.siguienteEstado(self)
  }

  method serCortada(tabla) {
    game.say(tabla, "Esto ya fue cortado")
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

  method ponerseEn(parrilla){
    parrilla.soltar(self)
  }

  method miRecetaEs() 

  override method entregarA(mesaDeEntrega){
    mesaDeEntrega.soltar(self)
  }
} 

class Asado inherits Carne {
  override method tiempoCoccion() = 16
  override method nombre() = "asado"
  
  //al tener animacion -- si hacemos asado cocido con animacion tmb lo tenemos q hacer
  override method image() {
    if(self.estaCocida()) {
      return "asado_cocido_" + animaciones.siguienteFrame(8) + ".png"
    }   
    //cosas de herencia cheta
    return super()
  }

  override method miRecetaEs() = platoAsado
}

class TiraAsado inherits ElementoAgarrable {
  
  const property image = "tira_asado.png" 

  override method initialize() {
    posicionEnSuelo = game.at(8,8)
  }

  method ponerseEn(parrilla){
    self.error("primero me tenes que cortar")
  }

  method serCortada(tabla) {
      const porcionAsado = new Asado(posicionEnSuelo = tabla.position()) 
            
      game.addVisual(porcionAsado)
      self.desaparecer()
  }

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

  override method miRecetaEs() = platoChori
}

class Morcilla inherits Carne{
  override method nombre() = "morcilla"
}

//esto es lo que explico la profe que esta re piola para poner el objeto vacio 
object noCarne {
  method cocinar(calor){}
  method comoAndas() = 0
  method seQuemo() = false
  method enLaParrilla(){}
  method fueraDeParrilla(){}
  method esCarne() = false
  method dejarAgarrarPor(parrilero){}
  method dejarEn(lugar) {} 
  method serCortada(tabla) {}
}