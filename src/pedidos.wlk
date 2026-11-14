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
    const timer = game.tick(1000, {self.expiroElPedido()}, false)

    
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
      self.empezarTimer()
    }

    method desaparecerPedido(){
      game.removeVisual(self)
      game.removeVisual(barraIndividual)
      self.registrarTiempo()
      self.terminarTimer()
      listadoPedidos.borrarPedido(self)
      listadoPedidos.acomodar()
    }

    method expiroElPedido(){
      if(self.tiempoRestante() == 0){
        self.desaparecerPedido()
        config.nivelActual().restarPuntos(10) 
      }
    }

    method empezarTimer() = timer.start()
    method terminarTimer() = timer.stop()

    method aceptoUn(pedido) = pedido.miRecetaEs() == pedidoActual and pedido.estaCocida() 

    method cumplirComanda(carne){
      config.nivelActual().sumarPuntos(20 + self.tiempoRestante())
      self.desaparecerPedido()
      carne.desaparecer()
    }   
    
}

object listadoPedidos inherits Chad{
  
  const property pedidos = []
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
  
  method estaElPedido(pedido) = pedidos.findOrDefault({comanda => comanda.aceptoUn(pedido)} , ningunPedido)
  
  method borrarPedido(pedido)
  {
    pedidos.remove(pedido)
  }
  method HayPedidos() = not pedidos.isEmpty()
  
  override method reiniciar() {
    pedidos.clear()
  }
}

object ningunPedido{
   method cumplirComanda(carne){
    config.nivelActual().restarPuntos(10)
    carne.desaparecer()
   }
}