import gameConfiguration.*

object dispenser {
    method image() = "dispenser.png"
    method position()= game.at(11, 7)
    method esAgarrable() = false
    method esSolido() = true
    method esParrilla() = false

    method initialize() {
        game.addVisual(self)
    }
}