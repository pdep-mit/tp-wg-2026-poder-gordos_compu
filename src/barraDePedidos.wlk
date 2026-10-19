import gameConfiguration.*

object barraDePedidos {
    method image() = "barra_pedidos.png"
    method position()= game.at(0, 11)
    method esAgarrable() = false
    method esSolido() = false
    method esParrilla() = false

    method initialize() {
        game.addVisual(self)
    }
}