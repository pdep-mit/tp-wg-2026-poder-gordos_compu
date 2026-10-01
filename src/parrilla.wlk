import wollok.game.*
import carnes.*

//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla {
//func: la parrilla solo puede tener una unica carne a la vez
//el fuego puede tener tres estados, 0 apagado, 1, poca llama, 2 media y 3 fuerte (se hace mas rapido pero se puede quemar)
//el fuego es un objeto que tiene un calor especifico 
var property fuego = apagado 
var property carneActual = noCarne 


method image() = "imagen de la parrilla"

method position(){}

method asar() = carneActual.cocinar(fuego.calor())



//... mas cosas
}

//el calor son puntos de coccion 
object apagado {
  method calor() = 0
}

object bajo {
  method calor() = 1
}

object medio {
  method calor() = 2 
}

object fuerte {
  method calor() = 3
}