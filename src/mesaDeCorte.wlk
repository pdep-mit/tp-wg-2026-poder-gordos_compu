import gameConfiguration.*
import superClaseChad.*
import elementosInvisibles.*

object mesaCorte inherits Chad {
    method image() = "mesa_corte.png"
    method position() = game.at(9, 0)
    method agregarVisuales(){
        game.addVisual(self)
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = 1))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = 2))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = 3))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = 4))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = 0))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = 1))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = 2))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = 3))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 2, desplazamientoY = 4))
    }

    override method esSolido() = true
}