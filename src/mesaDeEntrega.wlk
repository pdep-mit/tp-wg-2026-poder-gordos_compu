import src.movimientos.*
import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*
import pedidos.*

object mesaEntrega { 
  method image() = "mesa_pedidos.png"
  method position()= game.at(4, 9)
  method esAgarrable() = false
  method esSolido() = true
  method esParrilla() = false
  method esMesaDeEntrega() = true

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
      pedido.removeVisual()
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

  method recibir(carga){}
}

class ParteAuxiliarMesa {
  const desplazamientoX
  method esMesaDeEntrega() = true

  method position() = mesaEntrega.position().right(desplazamientoX)
  method esSolido() = true
  method esAgarrable() = false
  method esParrilla() = false
  method image() = "imagenInvisible.png"

  method entregarPedido(pedido) { mesaEntrega.entregarPedido(pedido) }
  method sumarPuntos(pedido) { mesaEntrega.sumarPuntos(pedido) }
  method restarPuntos(pedido) { mesaEntrega.restarPuntos(pedido) }
  method recibir(carga) { mesaEntrega.recibir(carga) }
}