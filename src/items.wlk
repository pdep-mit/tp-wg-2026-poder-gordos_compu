
import wollok.game.*
import itemFrame.*


// Null Object para cuando un elemento no está en posesión de nadie
object sinPortador {
  method muestraItemFrame() = false
  method posicionPara(item) = item.posicionEnSuelo()
  method dejarDeLlevar(algo){}
}

// superclase para cualquier cosa transportable por el asador u otros portadores
class ElementoAgarrable {
  var property portador = sinPortador
  var property posicionEnSuelo = game.at(5,5)

  method esAgarrable() = true
  method esParrilla() = false
  method position() = portador.posicionPara(self)

  method llevadoPor(algo){
    if (algo.muestraItemFrame()) {
      if (!game.hasVisual(itemFrame)) game.addVisual(itemFrame)
    } else {
      if (game.hasVisual(itemFrame)) game.removeVisual(itemFrame)
    }
    portador.dejarDeLlevar(self)
    portador = algo
  }

  method soltar() {
    if (game.hasVisual(itemFrame)) game.removeVisual(itemFrame)
    posicionEnSuelo = self.position()
    portador = sinPortador
  }
    
  // metodo para entregar el plato al comensal -- creo q deberia estar en asador
  method entregarA(comensal) {
    if (game.hasVisual(itemFrame)) game.removeVisual(itemFrame)
    comensal.recibirPedido(self)
  } 
}