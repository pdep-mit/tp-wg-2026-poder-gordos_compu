import wollok.game.*
import parrilla.*

object asador { 
  var property image = "asador_0.png"
  // metodo para cambiar el aspecto del asador
  method cambiarDireccion(nuevaDireccion) {
    image = nuevaDireccion
  }
  var property position = game.at(1,1)
}