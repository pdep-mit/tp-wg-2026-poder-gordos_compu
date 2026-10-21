import gameConfiguration.*
import superClaseChad.*
import elementosInvisibles.*

object mesaCorte inherits Chad {
    method image() = "mesa_corte.png"
    method position() = game.at(9, 0)
    method agregarVisuales(){
        game.addVisual(self)
        
        4.times({i => game.addVisual (new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = i))})
        5.times({i => game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = i - 1))})
    }

    override method esSolido() = true
}