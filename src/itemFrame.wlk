import wollok.game.*
import asador.*

object itemFrame {
    // Sigue la posición calculada por el asador
    method position() = asador.posicionPara(self)    
    method image() = "itemFrame.png"
}