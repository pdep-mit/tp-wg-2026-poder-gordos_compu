import carnes.*
import wollok.game.*
import parrilla.*
import movimientos.*

object sinCarga {
  method soltar(){}
  method esCarne() = false
}

// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo llevadoPor
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador { 
  var property image = "asador_0.png"
  var property position = game.at(1,1)
  var carga = sinCarga
  var property direccion = haciaAbajo

  var property pedidos = []
  
  method cambiarDireccion(numero) {
    image = "asador_" + numero + ".png"  
  }

  // la celda que tiene justo adelante, según para dónde mira
  method celdaDeEnfrente() = direccion.siguiente(position)

  method estaFrenteA(algo) = self.celdaDeEnfrente() == algo.position()

  method agarrar() {
    // solucion temporal para que no falle al intentar agarrar ciertos objetos por sobre otros
    const alcanzables = game.colliders(self).filter({plato => plato.esCarne()})
    if(!alcanzables.isEmpty())
    {
      self.soltar()
      carga = alcanzables.first()
      carga.llevadoPor(self)
    }
    
  }
  method soltar() {
    carga.soltar()
    carga = sinCarga
  }
  
  method tomarPedido(pedido) {
    self.pedidos().add(pedido)
  }

  // entregar plato
  method entregarA(comensal)
  {
    
  }

  method ponerCarne(){
    if(carga.esCarne() && not(parrilla.estaOcupada())&& self.estaFrenteA(parrilla)){
      parrilla.ponerCarne(carga)
      carga.llevadoPor(parrilla)
      carga = sinCarga
    } 
  }
  
  //se puede modificar 
  method posicionDeLoQueLlevo() = position.up(1).left(1)

  method esPortador() = true

}

// creamos objeto sin portador para que todos puedan calcular sus posiciones
object sinPortador {
  method posicionDeLoQueLlevo(){}
  method esPortador() = false
}