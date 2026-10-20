import carnes.*
import wollok.game.*
import parrilla.*
import movimientos.*
import items.*
import superClaseChad.* 

object sinCarga {
  method ponerseEn(carga){}
  method dejarEn(piso){}
  method apoyar(){}
  method agarrarCarga(parrilero){
    parrilero.agarrarLoDeEnfrente()
  }
}

// agregamos la logica para que pueda agarrar al contacto cualquier cosa que tenga implementado el metodo asignarA
// tambien el metodo para soltar, lo cual asigna como su nueva posicion la actual y se desvincula del gordo 
object asador inherits Chad { 
  var property position = game.at(1,1)
  var property carga = sinCarga
  var property direccion = haciaAbajo  
  
  //temp? 
  override method muestraItemFrame() = true

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

  

  method image() = "asador_" + direccion.toString() + ".png"  

  // la celda que tiene justo adelante, según para dónde mira
  method celdaDeEnfrente() = direccion.siguiente(position)

  method laPosicionObjeto() = position.up(2).right(1)

  method loQueTengoEnFrente() {
    const celdaLibre = new LugarLibre(celdaActual = self.celdaDeEnfrente())
    const cosasEnfrente = game.getObjectsIn(self.celdaDeEnfrente())
    cosasEnfrente.add(celdaLibre)
    return cosasEnfrente.first()
  }
    
  
  method ponerCarne(){
    self.loQueTengoEnFrente().recibir(carga)
  }

  //metodo super chad 
  method agarrar() {
    carga.agarrarCarga(self)
  }

  method tomar(nuevaCarga){
    carga = nuevaCarga
    nuevaCarga.asignarA(self)
  }
  
  method loQuePuedoAgarrar(){
    const misPies = game.getObjectsIn(self.position())
    misPies.remove(self)
    misPies.add(self.loQueTengoEnFrente())
    return misPies.first()
  }

  method agarrarLoDeEnfrente(){
    self.loQuePuedoAgarrar().dejarAgarrarPor(self)
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
