import pantallas.*
import wollok.game.*
import nivel_1.*
import gameConfiguration.*

object visualMenu {
    method position() = game.at(0, 0)
    method image() = "menu.png"
}

object menuPrincipal {
    const musicaFondo = game.sound("musica_fondo.mp3")
    const musicaMenu = game.sound("sonido_menu.mp3")
    
    method iniciar() {
        pantalla.estadoActual(enMenu)
        game.addVisual(visualMenu)
        musicaMenu.play()
        musicaMenu.shouldLoop(true)
    }

    method empezarJuego() {
        musicaMenu.stop()
        game.removeVisual(visualMenu)
        nivel1.arrancarNivel() 
        self.prender()
        pantalla.estadoActual(jugando)
    }
    
    method prender(){
        if(musicaFondo.paused()){
            musicaFondo.resume()
        }
        if(not musicaFondo.played()){
            musicaFondo.play()
            musicaFondo.shouldLoop(true)
        }
    }

    method apagar(){
        if(musicaFondo.paused()){
            musicaFondo.resume()
            musicaFondo.stop()
        }
        if(musicaFondo.played()){
            musicaFondo.stop()
        }
    }

    method pausar(){
        if(musicaFondo.played()){
            musicaFondo.pause()
        }
    }

    method reaunudar(){
        if(musicaFondo.paused()){
            musicaFondo.resume()
        }
    }
}