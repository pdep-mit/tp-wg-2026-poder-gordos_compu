import carnes.*
import barrasAviso.*
import gameConfiguration.*

class ElementoLista{
  // deberiamos vincularle un pedido para aplicar polimorfismo a 
  // la asignacion de imagen para cada plato
  // method tiempo() = pedido.tiempo()}
  // method image() = "pedido_" + pedido.nombre() + ".png"
  // falta retirar  
    var property pedidoActual 
    var property position = game.at(0, config.alturaMaxima() - 1)


    method image(){
      pedidoActual.nombre() + "_plato.png"
    }
    
    method cambiarPosicion(nuevaPosicionX, nuevaPosicionY) {
      position = game.at(nuevaPosicionX,nuevaPosicionY)
    }
    const barraIndividual = new BarraPedido(elementoActual = pedidoActual)
}

object listadoPedidos{
  const pedidos = []
  const property origen = game.at(1, config.alturaMaxima() - 1 )
  
  method tomarPedido(elemento){
    pedidos.add(elemento)
    self.acomodar()
    }
  method acomodar(){
    pedidos.forEach({elemento => elemento.position(origen.right(pedidos.indexOf(elemento)))})
  }
  method position() = origen
}