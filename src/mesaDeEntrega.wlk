import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*

class ElementoLista{ 
    var property pedidoActual 
    var property position = game.at(0, config.alturaMaxima() - 1)
    const barraIndividual = new BarraPedido(elementoActual = self)
    
    method tiempoRestante() = barraIndividual.duracionActual()
    // inicializo la barra de tiempo del plato y tambien su imagen de referencia
    method image(){
      pedidoActual.nombre() + "_plato.png"
      game.addVisual(barraIndividual)
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
  method tomarPedido(pedido){
    pedidos.add(pedido)
    self.acomodar()
    }
  method acomodar(){
    pedidos.forEach({pedido => pedido.position(origen.right(pedidos.indexOf(pedido)))})
  }
  
  method estaElPedido(pedido) = pedidos.contains(pedido)
  method borrarPedido(pedido)
  {
    const pedidoBuscado = pedidos.find({pedidoBuscado => pedidoBuscado.pedidoActual().nombre() == pedido.pedidoActual().nombre()})
    pedidoBuscado.registrarTiempo()
    pedidos.remove(pedidoBuscado) // agregar lo de remove visual (probablemente va en otro archivo)
  }
  method HayPedidos() = not pedidos.isEmpty()
}

object mesaEntrega { 
  method image() = "mesa_pedidos.png"
  method position()= game.at(4, 9)
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