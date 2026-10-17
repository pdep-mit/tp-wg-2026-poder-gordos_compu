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

  method recibir(carga){}
}

