import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*

class ElementoLista{ 
    var property pedidoActual 
    var property position = game.at(0, config.alturaMaxima() - 1)
    const barraIndividual = new BarraPedido(elementoActual = self)
    method tiempoRestante() = barraIndividual.duracionActual()
    method image(){
      pedidoActual.nombre() + "_plato.png"
    }
    
    method cambiarPosicion(nuevaPosicionX, nuevaPosicionY) {
      position = game.at(nuevaPosicionX,nuevaPosicionY)
    }
    
    method registrarTiempo()
    {
      barraIndividual.detener()
    }
}

object listadoPedidos{
  const pedidos = []
  const property origen = game.at(1, config.alturaMaxima() - 1 )
  method position() = origen
  method tomarPedido(elemento){
    pedidos.add(elemento)
    self.acomodar()
    }
  method acomodar(){
    pedidos.forEach({elemento => elemento.position(origen.right(pedidos.indexOf(elemento)))})
  }
  
  method estaElPedido(pedido) = pedidos.contains(pedido)
  method borrarPedido(pedido)
  {
    const pedidoBuscado = pedidos.find({pedidoBuscado => pedidoBuscado.pedidoActual().nombre() == pedido.pedidoActual().nombre()})
    pedidoBuscado.registrarTiempo()
    pedidos.remove(pedidoBuscado)
  }
  method HayPedidos() = not pedidos.isEmpty()
}

object mesaEntrega { 
  method image() = "mesa_pedidos.png"
  method position(){}
  method esAgarrable() = false

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