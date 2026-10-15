import wollok.game.*
import carnes.*
import animaciones.*

//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla {
  method muestraItemFrame() = false
  const property position = game.at(2,2)
  // variable temporal, cambiar implementacion en proximas entregas
  method esAgarrable() = false

  //Autoinicializa su propia otra parte, esto es fundamental para que agarrar pueda encontrar al objeto parrilla1 y que parrilla1 pueda delegar en la parrilla origianl
  method initialize() {
    game.addVisual(parrilla1)
  }
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

  // Polimorfismo con los contenedores para ubicar el item
  method posicionPara(item) = position

  //le preguntamos a la parrilla si esta libre para que le pongan una carne
  method estaOcupada() = carneActual.esCarne()

  method remover(carne){
    self.sacarCarne()
  }

  method esParrilla() = true

  method aceptaCarne() = not self.estaOcupada()

  method recibirCarne(carne) {
    self.ponerCarne(carne)
    carne.asignarA(self)
  }
  //... mas cosas
}

//Este es el objeto invisible que acompania a la parrilla para las colisiones y para poder cocinar
object parrilla1 {
  method muestraItemFrame() = false
  method esAgarrable() = false
  const property position = parrilla.position().right(1)

  method esParrilla() = true

  // Imagen transparente de 1x1 o vacía
  method image() = "imagenInvisible.png" 

  // Delegaciones a la parrilla real
  method estaOcupada() = parrilla.estaOcupada()
  method aceptaCarne() = parrilla.aceptaCarne()
  method recibirCarne(carne) { parrilla.recibirCarne(carne) }
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

//agregamos un tipo de fuego que sea mojado 
object mojado {
  //tal vez podriamos hacer que la parrilla mojada le reste tiempo de parrila a la carne 
  method calor() = 0

  method imagenParrilla() = "parrilla_mojada.png"

  method anterior() = self
  
  method siguiente() = apagado
}