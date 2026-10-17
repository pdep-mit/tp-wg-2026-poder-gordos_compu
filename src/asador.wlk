import carnes.*
import wollok.game.*
import parrilla.*
import movimientos.*
import items.*

object sinCarga {
  method soltar(){}
  method esAgarrable() = false
  method ponerseEn(carga){}
  method dejarEn(piso){}
  method apoyar(){}
}

// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo asignarA
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador { 
  var property position = game.at(1,1)
  var property carga = sinCarga
  var property direccion = haciaAbajo
  method esParrilla() = false
  method muestraItemFrame() = true
  method esSolido() = false
  
  // introducimos los puntos (a mejorar)
  var property puntos = 0

  method sumarPuntos(cantidad)
  {
    puntos += cantidad
  }

  method restarPuntos(cantidad)
  {
    puntos -= cantidad  
  }
  //Claramente el asador no es una parrilla, no?
  

  method image() = "asador_" + direccion.toString() + ".png"  

  // la celda que tiene justo adelante, según para dónde mira
  method celdaDeEnfrente() = direccion.siguiente(position)

  method laPosicionObjeto() = position.up(2).right(1)

  method loQueTengoEnFrente() {
    const celdaLibre = new LugarLibre(celdaActual = self.laPosicionObjeto())
    const cosasEnfrente = game.getObjectsIn(self.celdaDeEnfrente())
    cosasEnfrente.add(celdaLibre)
    return cosasEnfrente.first()
  }
    
 
  method ponerCarne(){
    self.loQueTengoEnFrente().recibir(carga)
  }


method agarrar() {
    const cosasEnfrente = game.getObjectsIn(self.celdaDeEnfrente())
    const cosasEnMisPies = game.getObjectsIn(position)
    
    // Filtramos para ignorar a nosotros mismos
    const cosasCerca = (cosasEnfrente + cosasEnMisPies).filter({ obj => obj != self })

    // 1. Buscamos primero si hay una carne cocinándose en la parrilla y estamos cerca de cualquier parte
    const hayParrillaOcupada = cosasCerca.any({ obj => obj.esParrilla() && obj.estaOcupada() })

    if (hayParrillaOcupada) {
      self.soltar()
      carga = parrilla.carneActual()
      carga.asignarA(self)
    } else {
      // 2. Si no hay parrilla con carne cerca, buscamos ítems sueltos en el piso o mesa
      const agarrables = cosasCerca.filter({ obj => obj.esAgarrable() })
      if (!agarrables.isEmpty()) {
        self.soltar()
        carga = agarrables.first()
        carga.asignarA(self)
      }
    }
  }
  

  method soltar() {
    carga.soltar()
    carga = sinCarga
  }

  // Posición polimórfica para el ítem que esta en el item frame, o sea en el inventario del asador
  method posicionPara(item) = self.laPosicionObjeto()

  //podria cambiar
  method remover(algo){
    carga = sinCarga
  }

  method avivarFuego() {    
    self.loQueTengoEnFrente().avivar()
  }  
}
