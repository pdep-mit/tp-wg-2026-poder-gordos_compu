import gameConfiguration.*


object mesaCorte {
    method image() = "mesa_corte.png"
    method position() = game.at(9, 0)
    method esAgarrable() = false
    method esSolido() = true
    method esParrilla() = false

    method initialize() {
        game.addVisual(self)
    }
}
