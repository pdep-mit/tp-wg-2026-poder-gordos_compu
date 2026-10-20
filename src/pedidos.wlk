import barrasAviso.*
import gameConfiguration.*
import superClaseChad.*

//esto seria un Pedido 
class ElementoLista inherits Chad{ 
    //seria un plato 
    const property pedidoActual 
    var property position = game.at(0, config.alturaMaxima() - 1)
    const barraIndividual = new BarraPedido(elementoActual = self)
    method tiempo() = pedidoActual.tiempoEntrega() 

    method tiempoRestante() = barraIndividual.duracionActual()
    // inicializo la barra de tiempo del plato y tambien su imagen de referencia
    method image() = pedidoActual.image()
    
    method cambiarPosicion(nuevaPosicionX, nuevaPosicionY) {
      position = game.at(nuevaPosicionX,nuevaPosicionY)
    }
    
    method registrarTiempo()
    {
      barraIndividual.detener()
    }

    method aparecerPedido(){
      game.addVisual(self)
      game.addVisual(barraIndividual)
      barraIndividual.acortarTiempo()
    }

    method desaparecerPedido(){
      game.removeVisual(self)
      game.removeVisual(barraIndividual)
      self.registrarTiempo()
    }
}

object listadoPedidos inherits Chad{
  const pedidos = []
  const property origen = game.at(0, config.alturaMaxima() - 1 )
  method position() = origen
  method tomarPedido(pedido){
    pedidos.add(pedido)
    pedido.aparecerPedido()
    self.acomodar()
    }
  method acomodar(){
    //se puede multiplicar *2 a la posicion para que esten mas espaciados pero solo podriamos tener 3 pedidos o agrandar la barra de pedidos
    pedidos.size().times({i => pedidos.get(i - 1).position(origen.right(i-1))})
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

