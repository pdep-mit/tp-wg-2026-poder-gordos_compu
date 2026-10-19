import gameConfiguration.*


//mover todo esto a coso para agarrar MP -- Tiene la super clase Chad que chad que es 
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