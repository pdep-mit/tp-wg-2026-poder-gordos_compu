import src.carnes.*
import wollok.game.*
import parrilla.*

object sinCarga {
  method soltar(){}
}
object asador { 
  var property image = "asador_0.png"
  var carga = sinCarga

  method cambiarDireccion(numero) {
    image = "asador_" + numero + ".png"  
  }

  method agarrar() {
    const alcanzables = game.colliders(self)
    if(!alcanzables.isEmpty())
    {
      self.soltar()
      carga = alcanzables.first()
      carga.llevadoPor(self)
    }
    
  }
  method soltar() {
    carga.soltar()
    carga = sinCarga
  }
  
  var property position = game.at(1,1)
}
