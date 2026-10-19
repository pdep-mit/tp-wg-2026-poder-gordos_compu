import wollok.game.*

object tablaDeCortar {
    method image() = "tabla_cortar.png"
    method position()= game.at(10, 4)
    method esAgarrable() = false
    method esSolido() = true
    method esParrilla() = false

    method initialize() {
        game.addVisual(self)
    }

    method cortar() {
        //Acá va la lógica de cortar la carne
        //Si ya está cortada, no hace nada
        //Habría que agregar estado de cortada true o false en la carne
    }
}