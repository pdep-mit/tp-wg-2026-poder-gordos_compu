import src.nivel_1.*
import src.gameConfiguration.*
import wollok.game.*
import asador.*
import movimientos.*
import menu.*
class EstadoDePantalla{
    method alApretarEnter(){}
    method alApretarT(){}
    method alApretarR(){}
    method alMover(direccion){}
    method alManipular(){}
    method alUsar(){}
    method alApretarM(){}
    method alApretarU(){}
    method alApretarD(){}
    method alApretar1(){}
    method alApretar2(){}
    method alApretarDelete(){}
    //esto es re bostero bocaaa bocaaa 
    method alApretarB(){}
}

object jugando inherits EstadoDePantalla {
    override method alMover(direccion) {
        asador.direccion(direccion)
        movimiento.mover(asador, direccion)
    }
    override method alManipular() { asador.manipular() }
    override method alUsar() { asador.usar() }
    override method alApretarM() { menuPrincipal.pausar() }
    override method alApretarU() { menuPrincipal.reaunudar() }
    override method alApretarB() { asador.cambiarDeSkin()
        asador.anunciarSkin()}
    override method alApretarDelete(){ 
        config.nivelActual().matarNivel()
        config.nivelActual().reiniciarNivel()

    }
}

object pantalla {
    var property estadoActual = enMenu

    method configurarTeclado() {
        keyboard.enter().onPressDo({ estadoActual.alApretarEnter() })
        keyboard.up().onPressDo({ estadoActual.alMover(haciaArriba) })
        keyboard.down().onPressDo({ estadoActual.alMover(haciaAbajo) })
        keyboard.left().onPressDo({ estadoActual.alMover(haciaLaIzquierda) })
        keyboard.right().onPressDo({ estadoActual.alMover(haciaLaDerecha) })
        keyboard.e().onPressDo({ estadoActual.alManipular() })
        keyboard.a().onPressDo({ estadoActual.alUsar() })
        keyboard.t().onPressDo({ estadoActual.alApretarT() })
        keyboard.r().onPressDo({ estadoActual.alApretarR() })
        keyboard.m().onPressDo({ estadoActual.alApretarM() })
        keyboard.u().onPressDo({ estadoActual.alApretarU() })
        keyboard.d().onPressDo({ estadoActual.alApretarD() })
        keyboard.num1().onPressDo({ estadoActual.alApretar1() })
        keyboard.num2().onPressDo({ estadoActual.alApretar2() })
        keyboard.b().onPressDo({ estadoActual.alApretarB() })
        keyboard.backspace().onPressDo({ estadoActual.alApretarDelete() })
    }
}

object enMenu inherits EstadoDePantalla{
    override method alApretarEnter(){ menuPrincipal.empezarJuego() }

    override method alApretarT(){ 
        game.addVisual(controles)
        pantalla.estadoActual(enControles) }

    override method alApretarD(){
        game.addVisual(dificultad)
        pantalla.estadoActual(selectorDificultad)
    }
}

object controles {
    method image() = "controles.png"
    method position() = game.at(0,0)
}

object dificultad{
    var property dificultadElegida = dificultadNormal
    
    method image() = dificultadElegida.image()
    method position() = game.at(0,0)

    method elegirDificultad(direccion){

    }
}

object enControles inherits EstadoDePantalla {
    override method alApretarT(){ 
        game.removeVisual(controles)
        pantalla.estadoActual(enMenu) }
}

object nivelTerminado inherits EstadoDePantalla{
    
    override method alApretarR(){ config.nivelActual().reiniciarNivel() }
}

object selectorDificultad inherits EstadoDePantalla{
    override method alApretarD(){
        game.removeVisual(dificultad)
        pantalla.estadoActual(enMenu)
    }

    override method alApretar1(){
        config.nivelActual(nivel1Facil)
        dificultad.dificultadElegida(dificultadNormal)
    }

    override method alApretar2(){
        config.nivelActual(nivel1Dificil)
        dificultad.dificultadElegida(dificultadDificil)
    }

    override method alMover(direccion){
        direccion.elegirDificultad()
    }
}

object dificultadNormal {
  method image() = "dificultad_normal.png"
}

object dificultadDificil {
  method image() = "dificultad_dificil.png"
}