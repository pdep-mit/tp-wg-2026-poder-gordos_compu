import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*
import pedidos.*

object mesaEntrega { 
  method image() = "mesa_pedidos.png"
  method position()= game.at(4, 9)
  method esAgarrable() = false

  method initialize() {
    game.addVisual(mesaDeEntrega1)
    game.addVisual(mesaDeEntrega2)
    game.addVisual(mesaDeEntrega3)
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

// ESTOY HAY QUE REVISARLO QUIZAS HACIENDO LA MESA DE ENTREGA MAS CHICA ESTO QUEDE MEJOR PERO ASI COMO ESTA HAY UN MONTON DE REPETICION DE LOGICA
object mesaDeEntrega1{
  method position()= game.at(5, 9)
  method esAgarrable() = false
  method image() = "imagenInvisible.png" 
  
  
  method entregarPedido(pedido) {mesaEntrega.entregarPedido(pedido) }
  method sumarPuntos(pedido) {mesaEntrega.sumarPuntos(pedido)}
  method restarPuntos(pedido) {mesaEntrega.restarPuntos(pedido)}
}
object mesaDeEntrega2{
  method position()= game.at(6, 9)
  method esAgarrable() = false
  method image() = "imagenInvisible.png" 
  

  method entregarPedido(pedido) {mesaEntrega.entregarPedido(pedido) }
  method sumarPuntos(pedido) {mesaEntrega.sumarPuntos(pedido)}
  method restarPuntos(pedido) {mesaEntrega.restarPuntos(pedido)}
}
object mesaDeEntrega3{
  method position()= game.at(7, 9)
  method esAgarrable() = false
  method image() = "imagenInvisible.png" 
  

  method entregarPedido(pedido) {mesaEntrega.entregarPedido(pedido) }
  method sumarPuntos(pedido) {mesaEntrega.sumarPuntos(pedido)}
  method restarPuntos(pedido) {mesaEntrega.restarPuntos(pedido)}
}