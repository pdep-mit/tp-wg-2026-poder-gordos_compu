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
  method entregarA(mesaDeEntrega){}
  method validarSiEsCortable() {
    self.error("No podés cortar el aire, ¡agarrá algo primero!")
  }
}

//el pj principal
object asador inherits Chad { 
  var property position = game.at(1,1)
  var property carga = sinCarga
  var property direccion = haciaAbajo  
  
  override method reiniciar() {
    position = game.at(1,1)
    self.direccion(haciaAbajo)
    carga = sinCarga
  }
  
  override method muestraItemFrame() = true

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
    
  
  method soltar(){
    self.loQueTengoEnFrente().recibir(carga)
  }

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
  
  //Posición polimórfica para el ítem que esta en el item frame, o sea en el inventario del asador
  method posicionPara(item) = self.laPosicionObjeto()

  //podria cambiar
  method remover(algo){
    carga = sinCarga
  }

  method avivarFuego() {    
    self.loQueTengoEnFrente().avivar()
  }  

  override method cortar(){
    self.loQueTengoEnFrente().cortar()
  }
}
