import asador.*
import gameConfiguration.*
import wollok.game.*
import itemFrame.*
import superClaseChad.*
import elementosInvisibles.*

// Null Object para cuando un elemento no está en un contenedor
// O sea esta en el piso
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
  const elementoInvisible = new ElementoAuxiliar(duenio = self, desplazamientoX = 1)
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
    //aca hay polimorfismo
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
  
  //no hace nada pq tendrias que solar primero lo que tenes para poder agarrar una nueva carne -- se pude modificar 
  method agarrarCarga(parrillero){}

  method mostrarParteInvisible(){
    game.addVisual(elementoInvisible)
  }

  method entregarA(mesaDeEntrega){
    self.error("esto no se puede entregar")
  }

  method desaparecer(){
    contenedor.remover(self)
    itemFrame.ocultar()
    game.removeVisual(self)
    if (game.hasVisual(elementoInvisible)){
      game.removeVisual(elementoInvisible)
    }
  }

  method serCortada(tabla) {}
  
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

