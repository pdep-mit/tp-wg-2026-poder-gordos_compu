import asador.*
import gameConfiguration.*
import wollok.game.*
import itemFrame.*
import superClaseChad.*
import elementosInvisibles.*

object sinContenedor {
  method muestraItemFrame() = false
  method posicionPara(item) = item.posicionEnSuelo()
  //Cuando el piso lo deja de llevar no tiene que hacer nada
  method remover(unItem){}
}

// superclase para cualquier cosa transportable por el inventario del asador u otros contenedores
class ElementoAgarrable inherits Chad {
  //Origianlmente el item esta en el piso
  var property contenedor = sinContenedor
  var property posicionEnSuelo
  method position() = contenedor.posicionPara(self)

  //Le asginamos un nuevo contenedor al item
  method asignarA(nuevoContenedor){
    // 1. Delegación limpia a la UI
    if (nuevoContenedor.muestraItemFrame()) {
      itemFrame.mostrar()
    } else {
      itemFrame.ocultar()
    }

    contenedor.remover(self)
    //Adopcion del nuevo dueno
    contenedor = nuevoContenedor
  }

  /*
  * metodo para que no se pueda poner una carne arriba de otra
  */
  override method recibir(carga){
    carga.apoyar()
  }

  method dejarEn(piso){
    posicionEnSuelo = piso.celdaActual()
    self.asignarA(sinContenedor)
  }

  method apoyar(){
    self.error("hay algo ya apoyado")
  }

  override method dejarAgarrarPor(parrillero){
    parrillero.tomar(self)
  }
  
  method serManipuladaPor(parrillero){
    parrillero.soltar()
  }

  method entregarA(mesaDeEntrega){
    self.error("esto no se puede entregar")
  }

  method desaparecer(){
    contenedor.remover(self)
    itemFrame.ocultar()
    game.removeVisual(self)
  }

  method validarSiEsCortable() {}  

  method intentarCortarseEn(tabla){
    self.error("no se puede cortar")
  }
}

/*
* clase que representa las casillas libres en el tablero 
*/ 
class LugarLibre inherits Chad{
  var property celdaActual 

  override method recibir(carga){
    //valida que no este en el borde
    if(not self.estaAdentro()) 
      asador.error("casi se me cae ufff 💧")
    carga.dejarEn(self)
  }

  method estaAdentro() = config.esCeldaPermitida(self)

}

