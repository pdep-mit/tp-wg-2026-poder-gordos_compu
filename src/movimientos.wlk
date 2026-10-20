import gameConfiguration.*
import parrilla.*
import mesaDeEntrega.*
/*
* Acá se define cómo se mueven los personajes cuando se usan las flechitas.
* Las posiciones son objetos inmutables, pero los personajes controlados pueden
* moverse setteándose la nueva posición cuando sea necesario.
*/
//Movimiento comprueba las colisiones y si no hay colisiones con objetos solidos entonces avanza a la nueva posicion dada por los objetos de mas abajo ejecutados en 
// gameconfiguration por las flechas
object movimiento {

	method mover(personajeLibre, direccion)
    {   
        const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
        //Chequeamos si en la nueva posicion hay solidos
        const haySolidos = game.getObjectsIn(nuevaPosicion).any({ obj => obj.esSolido() })

        //Si no hay solidos avanzo :))
        if (!haySolidos) {
            personajeLibre.position(nuevaPosicion)
        }
    }
}

object haciaArriba {
    method posicionSiguiente(posicion) = game.at(posicion.x(),(config.alturaMaxima()-3).min(posicion.up(1).y()))

    method siguiente(posicion) =  posicion.up(1)
}

object haciaAbajo {
	method posicionSiguiente(posicion) = game.at(posicion.x(),0.max(posicion.down(1).y()))

    method siguiente(posicion) =  posicion.down(1)
}

object haciaLaDerecha {
	method posicionSiguiente(posicion) = game.at((config.anchoMaximo()-1).min(posicion.right(1).x()),posicion.y())

    method siguiente(posicion) =  posicion.right(1)
}

object haciaLaIzquierda {
	method posicionSiguiente(posicion) = game.at(0.max(posicion.left(1).x()),posicion.y())

    method siguiente(posicion) =  posicion.left(1)
}