import wollok.game.*
import carnes.*
import animaciones.*


//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla {
const property position = game.at(2,2)
// variable temporal, cambiar implementacion en proximas entregas
const property esCarne = false

//func: la parrilla solo puede tener una unica carne a la vez
//el fuego puede tener tres estados, 0 apagado, 1, poca llama, 2 media y 3 fuerte (se hace mas rapido pero se puede quemar)
//el fuego es un objeto que tiene un calor especifico 
var property fuego = fuerte
var property carneActual = noCarne 


method image() = fuego.imagenParrilla()

//absolute cinema -- la parrilla "asa" cada 1 segundo pero dependiendo del fuego se cocinara mas lento o mas rapido 
method asar() = carneActual.cocinar(fuego.calor())

method ponerCarne(carne) {
  carneActual = carne
  carne.enLaParrilla()
} 

method sacarCarne(){
  carneActual.fueraDeParrilla()
  carneActual = noCarne
}

//puede que este metodo le pertenezca al asador 
method avivar(){
  //deberia tardar un toque en avivar el fuego que no sea instantaneo tal vez resetear el contador
  //tambien debeiria resetear el tiempo en el que se apaga el fuego un poco 
  fuego = fuego.siguiente()
}

method posicionDeLoQueLlevo() = position

//le preguntamos a la parrilla si esta libre para que le pongan una carne
method estaOcupada() = carneActual.esCarne()

method esPortador() = true


//podria cambiar
method dejarDeLlevar(carne){
  self.sacarCarne()
}
//... mas cosas
}

//el calor son puntos de coccion 
object apagado {
  method calor() = 0

  method imagenParrilla() = "parrilla_apagada.png"


  method anterior() = self

  method siguiente() = bajo 

}


object bajo {
  method calor() = 1

  method imagenParrilla() = "parrilla_bajo_" + animaciones.siguienteFrame(8) + ".png"

  method anterior() = apagado
  
  method siguiente() = medio

}

object medio {
  method calor() = 2 

  method imagenParrilla() = "parrilla_medio_" + animaciones.siguienteFrame(8) + ".png"

  method anterior() = bajo
  
  method siguiente() = fuerte
}

object fuerte {
  method calor() = 3

  method imagenParrilla() = "parrilla_alto_" + animaciones.siguienteFrame(8) + ".png" 

   method anterior() = medio
  
  method siguiente() = self

}