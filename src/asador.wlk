import src.carnes.*
import wollok.game.*
import parrilla.*

object sinCarga {
  method soltar(){}
}
class Pedido {
  var property nombre
  const property tiempo
  var property entregado = false
}
// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo llevadoPor
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador { 
  var property image = "asador_0.png"
  var property position = game.at(1,1)
  var carga = sinCarga
  var property pedidos = []
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
  
  method tomarPedido(pedido) {
    self.pedidos().add(pedido)
  }

  // entregar plato
  method entregarA(comensal)
  {
    
  }
}
