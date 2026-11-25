import gameConfiguration.*
import parrilla.*
import mesaDeEntrega.*
import tablaDeCortar.*
import pantallas.*
import nivel_1.*
object movimiento {

	method mover(personajeLibre, direccion)
    {   
        const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
        //Chequeamos si en la nueva posicion hay solidos
        const haySolidos = game.getObjectsIn(nuevaPosicion).any({ obj => obj.esSolido() })

        //Si no hay solidos avanzo :))
        if (!haySolidos) {
            //esto es re croto 
            parrilla.reiniciarEsfuerzo()
            tablaDeCortar.reiniciarEsfuerzo()
            personajeLibre.position(nuevaPosicion)
        }
    }
}

object haciaArriba {
    method posicionSiguiente(posicion) = game.at(posicion.x(),(config.alturaMaxima()-3).min(posicion.up(1).y()))

    method siguiente(posicion) =  posicion.up(1)

    method elegirDificultad(){
        config.nivelActual(nivel1Facil)
        dificultad.dificultadElegida(dificultadNormal)
    }
}

object haciaAbajo {
	method posicionSiguiente(posicion) = game.at(posicion.x(),0.max(posicion.down(1).y()))

    method siguiente(posicion) =  posicion.down(1)

    method elegirDificultad(){
        config.nivelActual(nivel1Dificil)
        dificultad.dificultadElegida(dificultadDificil)
    }
}

object haciaLaDerecha {
	method posicionSiguiente(posicion) = game.at((config.anchoMaximo()-1).min(posicion.right(1).x()),posicion.y())

    method siguiente(posicion) =  posicion.right(1)

    method elegirDificultad(){}
}

object haciaLaIzquierda {
	method posicionSiguiente(posicion) = game.at(0.max(posicion.left(1).x()),posicion.y())

    method siguiente(posicion) =  posicion.left(1)

    method elegirDificultad(){}
}