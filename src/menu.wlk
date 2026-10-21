import wollok.game.*
import src.nivel_1.*
import src.gameConfiguration.*

object visualMenu {
    method position() = game.at(0, 0)
    method image() = "menu.png"
}

object menuPrincipal {
    method iniciar() {
        game.addVisual(visualMenu)

        keyboard.enter().onPressDo {
            self.empezarJuego()
        }
    }

    method empezarJuego() {
        if (game.hasVisual(visualMenu)) {
            game.removeVisual(visualMenu)
        }
        nivel1.arrancarNivel() 
    }
}