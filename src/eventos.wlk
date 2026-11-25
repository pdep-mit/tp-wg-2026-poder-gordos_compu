import asador.*
import animaciones.*
import wollok.game.*
import parrilla.*
import superClaseChad.*

object lluvia{
    method mojarParrilla() { 
        //parrilla.fuego(mojado) 
    } 

    //poner chapa en la parrilla para protegerla de lluvia
    //nubes de lluvia 
    //podriamos hacer una imagen que caiga por toda la pantalla simulando la lluvia
    //cuando pase que la parrila se quede mojada y te cuesta mas prenderla -- ver avivar 
    //hacer charcos en el piso 
    //ver -> capaz que afecta a la carne de alguna forma 
}

class Viento{
    const sonidoViento = game.sound("sonido_viento.mp3")
    const tiempoBajadaFuego = game.tick(self.tiempoBajadaFuego(), {parrilla.apagarPoco()} ,false)
    const nubeIzquierda = new Nube(position = game.at(0,9))
    const nubeMedioDerecha = new Nube(position = game.at(10,11))
    const nubeMedio = new Nube(position = game.at(6,11))
    const nubeMedioDerechaX2 = new Nube(position = game.at(14,11))
    const nubes = [nubeIzquierda, nubeMedio, nubeDoble, nubeMedioDerecha, nubeMedioDerechaX2]

    //el tiempo que tarda el viento en bajar el fuego de la parrilla
    method tiempoBajadaFuego()

    method empezarEvento(){
        self.agregarNubes()
        self.emepzarSonido()
        tiempoBajadaFuego.start()
    }

    method terminarEvento(){
        tiempoBajadaFuego.stop()
        self.apagarSonido()
        self.sacarNubes()
        molinete.frenar()
    }

    method agregarNubes(){
        nubes.forEach({nube => game.addVisual(nube)})
        game.schedule(1000, {game.addVisual(rafaga) 
        molinete.girar()})
    }

    method emepzarSonido(){
        if(not sonidoViento.played()){
            sonidoViento.play()
            sonidoViento.shouldLoop(true)
        }
    }

    method apagarSonido(){
        if(sonidoViento.played()){
            sonidoViento.stop()
        }
    }

    method sacarNubes(){
        nubes.forEach({nube => game.removeVisual(nube)})
        game.removeVisual(rafaga)
    }

    method momentoDeFin(arranque) = arranque + 20000

    method anunciarEvento() {
        game.say(asador, "tiene pinta que se viene una ventisca...")
    }
}

object vientoFacil inherits Viento{
    override method tiempoBajadaFuego() = 5000 
}

object vientoDificil inherits Viento {
    override method tiempoBajadaFuego() = 2000
}

class Nube{
    method image() = "nube.png"

    const property position 
}

object nubeDoble{
    method image() = "nube_doble.png"

    method position() = game.at(18,11)
}

object rafaga{
    method image() = "viento_" + animaciones.siguienteFrame(4) + ".png"

    method position() = game.at(1,9)
}

object molinete inherits Chad{
    var estaGirando = false 
    
    method position() = game.at(17,0)

    method image() {
        if(estaGirando){
            return "molinete_" + animaciones.siguienteFrame(6) + ".png"
        } else {
            return "molinete_0.png"
        }
    }

    method girar(){
        estaGirando = true
    } 

    method frenar(){
        estaGirando = false
    }
}

object tio {
    //medio falopa te roba la comida 
}

object neblina {
    //te invierte los controles y aparece un leve asset de algo que te haga dar cuenta de que hay neblina 
}

object eventoHalloween{
    //la carne se va volando y la tenes que perseguir o aparece en lugares random
}


//opcional 
/* object meteorito {
  
} */

object despejado{
    method empezarEvento(){}
    method terminarEvento(){}
    method momentoDeFin(arranque) = arranque
    method anunciarEvento(){}
}