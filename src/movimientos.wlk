//robe los movimientos de halloween
import gameConfiguration.*

/*
* Acá se define cómo se mueven los personajes cuando se usan las flechitas.
* Las posiciones son objetos inmutables, pero los personajes controlados pueden
* moverse setteándose la nueva posición cuando sea necesario.
*
* Esta versión anda, pero deja que los chicos se vayan de la pantalla.
* Cada dirección tiene que hacerse cargo de su propio borde.
*/

object movimiento {
	method mover(personajeLibre, direccion){
		const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
		personajeLibre.position(nuevaPosicion)
	}
}

object haciaArriba {
    method posicionSiguiente(posicion) = game.at(posicion.x(),(config.alturaMaxima()-2).min(posicion.up(1).y()))

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