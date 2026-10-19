import wollok.game.*
import superClaseChad.*

object tablaDeCortar inherits Chad {
    method image() = "tabla_cortar.png"
    method position()= game.at(10, 4)
    override method esSolido() = true

    method initialize() {
        game.addVisual(self)
    }

    method cortar() {
        //Acá va la lógica de cortar la carne
        //Si ya está cortada, no hace nada
        //Habría que agregar estado de cortada true o false en la carne
    }
}