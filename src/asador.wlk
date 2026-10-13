import carnes.*
import wollok.game.*
import parrilla.*
import movimientos.*


object sinCarga {
  method soltar(){}
  method esAgarrable() = false
}

// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo llevadoPor
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador { 
  var property position = game.at(1,1)
  var property carga = sinCarga
  var property direccion = haciaAbajo

  //Capaz quedo viejo(?)
  var property pedidos = []

  method muestraItemFrame() = true

  method image() = "asador_" + direccion.toString() + ".png"  

  // la celda que tiene justo adelante, según para dónde mira
  method celdaDeEnfrente() = direccion.siguiente(position)

  method estaFrenteA(algo) = self.celdaDeEnfrente() == algo.position()

   method ponerCarne(){
    if(carga.esCarne() && not(parrilla.estaOcupada())&& (self.estaFrenteA(parrilla) || self.estaFrenteA(parrilla1))){
      parrilla.ponerCarne(carga)
      carga.llevadoPor(parrilla)
      carga = sinCarga
    } 
    carga.noSePuedeCocinar()
  }

  method agarrar() {
    // solucion temporal para que no falle al intentar agarrar ciertos objetos por sobre otros
    const alcanzables = game.colliders(self).filter({plato => plato.esAgarrable()})
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

 
  
  //se puede modificar 
  method posicionDeLoQueLlevo() = position.up(2).right(1)

  method esPortador() = true

  //podria cambiar
  method dejarDeLlevar(algo){
    carga = sinCarga
  }


  method avivarFuego(){
    if(self.estaFrenteA(parrilla) || self.estaFrenteA(parrilla1))
    {
      parrilla.fuego(parrilla.fuego().siguiente())
    }  
  }
}


// RAMA PORFAVOR REVISA ESTO ME ARDEN LOS OJOS AHHHH LLORO SANGRE
// creamos objeto sin portador para que todos puedan calcular sus posiciones
object sinPortador {
  method muestraItemFrame() = false
  method posicionDeLoQueLlevo(){}
  method esPortador() = false
  method dejarDeLlevar(algo){}
}