import gameConfiguration.*
import wollok.game.*
import itemFrame.*


// Null Object para cuando un elemento no está en un contenedor
// O sea esta en el piso
object sinContenedor {
  method muestraItemFrame() = false
  method posicionPara(item) = item.posicionEnSuelo()
  //Cuando el piso lo deja de llevar no tiene que hacer nada
  method remover(unItem){}
}

// superclase para cualquier cosa transportable por el inventario del asador u otros contenedores
class ElementoAgarrable {
  //Origianlmente el item esta en el piso
  var property contenedor = sinContenedor
  var property posicionEnSuelo

  method esAgarrable() = true
  method esParrilla() = false
  method position() = contenedor.posicionPara(self)

  //Le asginamos un nuevo contenedor al item
  method asignarA(nuevoContenedor){
    // 1. Delegación limpia a la UI
    if (nuevoContenedor.muestraItemFrame()) {
      itemFrame.mostrar()
    } else {
      itemFrame.ocultar()
    }

    //Desvinculamos del contenedor anterior
    //Cada tipo de contenedor va a tener una forma deiferente de dejarDeLlevar
    contenedor.remover(self)
    //Adopcion del nuevo dueno
    contenedor = nuevoContenedor
  }

 method soltar() {
  posicionEnSuelo = self.position()
  self.asignarA(sinContenedor)
}

  // metodo para entregar el plato al comensal -- creo q deberia estar en asador
  method entregarA(comensal) {
    if (game.hasVisual(itemFrame)) game.removeVisual(itemFrame)
    comensal.recibirPedido(self)
  }

  /*
  * metodo para que no se pueda poner una carne arriba de otra
  */
  method recibir(carga){
    self.error("hay algo ya apoyado")
  }

  method dejarEn(piso){
    posicionEnSuelo = piso.celdaActual()
    self.asignarA(sinContenedor)
  }
}

/*
* clase que representa las casillas libres en el tablero 
*/ 
class LugarLibre{
  var property celdaActual 

  method recibir(carga){
    //valida que no este en el borde
    if(not self.estaAdentro()) 
      self.error("casi se me cae ufff 💧")
    carga.dejarEn(self)
  }

  method estaAdentro() = config.esCeldaPermitida(self)
}

