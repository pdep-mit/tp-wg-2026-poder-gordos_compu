import gameConfiguration.*
import superClaseChad.*
import elementosInvisibles.*

object mesaCorte inherits Chad {
    method image() = "mesa_corte.png"
    method position() = game.at(9, 0)

    method initialize() {
        game.addVisual(self)
 
    }

    override method esSolido() = false
}
