import wollok.game.*
import asador.*

object itemFrame {
    // Sigue la posición calculada por el asador
    method position() = asador.posicionPara(self)    
    method image() = "itemFrame.png"

    method mostrar() {
    if (!game.hasVisual(self)) {
      game.addVisual(self)
    }
  }
  // Se encarga él mismo de quitarse si está
  method ocultar() {
    if (game.hasVisual(self)) {
      game.removeVisual(self)
    }
  }
}