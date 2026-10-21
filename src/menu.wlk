import wollok.game.*
import src.nivel_1.* // Ajustá este import según dónde esté tu nivel1
import src.gameConfiguration.*

object menuPrincipal {
    
    method iniciar() {
        game.boardGround("menu.jpg") 

        // Dejo esto por si quieremos agregar una musiquita
        // const musicaMenu = game.sound("musica_intro.mp3")
        // musicaMenu.play()

        // Tocar enter para arrancar
        keyboard.enter().onPressDo {
            self.empezarJuego()
        }
    }

    method empezarJuego() {
        game.clear() 
        game.boardGround("fondo.png") 
        nivel1.arrancarNivel() 
    }
}