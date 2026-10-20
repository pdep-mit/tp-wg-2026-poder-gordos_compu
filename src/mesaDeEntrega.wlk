import src.movimientos.*
import src.asador.*
import carnes.*
import barrasAviso.*
import gameConfiguration.*
import pedidos.*
import superClaseChad.*
import elementosInvisibles.*

object mesaEntrega inherits Chad { 
  //la tenemos que agrandar 
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
  
  override method recibir(carga){
    carga.entregarA(self)
  }

  method soltar(carga){
    const pedidoBuscado = listadoPedidos.estaElPedido(carga)
    pedidoBuscado.cumplirComanda(carga)

  }
 

}

