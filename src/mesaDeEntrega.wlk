import src.movimientos.*
import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*
import pedidos.*
import superClaseChad.*

object mesaEntrega inherits Chad { 
  method image() = "mesa_pedidos.png"
  method position()= game.at(7, 9)

  override method esSolido() = true

  method initialize() {
    game.addVisual(new ParteAuxiliarMesa(desplazamientoX = 1))
    game.addVisual(new ParteAuxiliarMesa(desplazamientoX = 2))
    game.addVisual(new ParteAuxiliarMesa(desplazamientoX = 3))
  }
  
  method entregarPedido(pedido)
  {
    if(not listadoPedidos.HayPedidos())
    {
      self.error("No hay Pedidos Disponibles para entregar")
    }
    if(listadoPedidos.estaElPedido(pedido))
    {
      self.sumarPuntos(pedido)
      listadoPedidos.borrarPedido(pedido)
    }
    else
    {
      self.restarPuntos(pedido)
    }
  }
  method sumarPuntos(pedido)
  {
    asador.sumarPuntos(20 + pedido.tiempoRestante())
  }
  method restarPuntos(pedido)
  {
    asador.restarPuntos(10)
  }
}

class ParteAuxiliarMesa inherits Chad {
  const desplazamientoX

  method position() = mesaEntrega.position().right(desplazamientoX)
  method image() = "imagenInvisible.png"

  method entregarPedido(pedido) { mesaEntrega.entregarPedido(pedido) }
  method sumarPuntos(pedido) { mesaEntrega.sumarPuntos(pedido) }
  method restarPuntos(pedido) { mesaEntrega.restarPuntos(pedido) }
  
  override method esSolido() = true

}
