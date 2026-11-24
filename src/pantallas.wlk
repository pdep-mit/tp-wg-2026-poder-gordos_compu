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
    }
}

object enMenu inherits EstadoDePantalla{
    override method alApretarEnter(){ menuPrincipal.empezarJuego() }

    override method alApretarT(){ 
        game.addVisual(controles)
        pantalla.estadoActual(enControles) }
}

object controles {
    method image() = "controles.png"
    method position() = game.at(0,0)
}

object enControles inherits EstadoDePantalla {
    override method alApretarT(){ 
        game.removeVisual(controles)
        pantalla.estadoActual(enMenu) }
}

object nivelTerminado inherits EstadoDePantalla{
    override method alApretarR(){config.nivelActual().reiniciarNivel()}
}
