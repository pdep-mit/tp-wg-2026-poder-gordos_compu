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
  method serManipuladaPor(parrilero){
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
  var property skin = gordoParrillero 

  method reiniciar() {
    position = game.at(1,1)
    self.direccion(haciaAbajo)
    carga = sinCarga
    skin = gordoParrillero
  }
  
  method muestraItemFrame() = true

  method image() = skin.image(direccion) 

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

  method manipular() {
    carga.serManipuladaPor(self)
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

  override method usar(){
    self.loQueTengoEnFrente().usar()
  }

  method cambiarDeSkin(){
    skin = skin.otra()
  }

  method anunciarSkin(){ skin.anunciarSkin() } 
}

object gordoParrillero {
  method image(direccion) = "asador_" + direccion.toString() + ".png" 

  method otra() = enandoDeBoca

  method anunciarSkin(){}
}

object enandoDeBoca {
  method image(direccion) = "asador_bostero_" + direccion.toString() + ".png" 

  method otra() = gordoParrillero

  method anunciarSkin(){
    game.say(asador, "boca bocaaaa que grande bocaaa")
  }
}