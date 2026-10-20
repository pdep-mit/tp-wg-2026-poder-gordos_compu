import src.movimientos.*
import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*
import pedidos.*
import superClaseChad.*
import elementosInvisibles.*

object mesaEntrega inherits Chad { 
  method image() = "mesa_pedidos.png"
  method position()= game.at(7, 9)

  override method esSolido() = true

  method initialize() {
    game.addVisual(new ElementoAuxiliar(duenio = self, desplazamientoX = 1))
    game.addVisual(new ElementoAuxiliar(duenio = self, desplazamientoX = 2))
    game.addVisual(new ElementoAuxiliar(duenio = self, desplazamientoX = 3))

    //otra opcion 
    //3.times({i => new ElementoAuxiliar(duenio = self, desplazamientoX = i)})
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

