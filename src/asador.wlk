import carnes.*
import wollok.game.*
import parrilla.*
import movimientos.*

object sinCarga {
  method soltar(){}
  method esAgarrable() = false
  method esCarne() = false
}

// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo asignarA
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador { 
  var property position = game.at(1,1)
  var property carga = sinCarga
  var property direccion = haciaAbajo

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
  method esParrilla() = false
  method esMesaDeEntrega() = false

  method muestraItemFrame() = true

  method image() = "asador_" + direccion.toString() + ".png"  

  // la celda que tiene justo adelante, según para dónde mira
  method celdaDeEnfrente() = direccion.siguiente(position)

  method estaFrenteA(algo) = self.celdaDeEnfrente() == algo.position()

  method ponerCarne(){
   if (carga.esCarne()) {
      // Busca qué hay en la celda de enfrente
      const cosasEnfrente = game.getObjectsIn(self.celdaDeEnfrente())
      
      // Filtra las que sean parrilla y que además acepten carne 
      //quizas se puede reutiliar para la mesa de entrega
      const destinos = cosasEnfrente.filter({ obj => obj.esParrilla() && obj.aceptaCarne() })

      if (!destinos.isEmpty()) {
        destinos.first().recibirCarne(carga)
        carga = sinCarga
      }
    }
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
  method posicionPara(item) = position.up(2).right(1)

  //podria cambiar
  method remover(algo){
    carga = sinCarga
  }

  method avivarFuego() {
  const cosasEnfrente = game.getObjectsIn(self.celdaDeEnfrente())
  const parrillasEnfrente = cosasEnfrente.filter({ obj => obj.esParrilla() })
  
  if (!parrillasEnfrente.isEmpty()) {
    parrilla.fuego(parrilla.fuego().siguiente())
  }
}
}