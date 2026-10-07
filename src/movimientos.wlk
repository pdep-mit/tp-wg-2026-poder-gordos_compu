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
	// TODO: no se puede subir más arriba del cielo
    method posicionSiguiente(posicion) = game.at(posicion.x(),(config.alturaMaxima()-2).min(posicion.up(1).y()))

    method siguiente(posicion) =  posicion.up(1)
}

object haciaAbajo {
	// TODO: no se puede bajar más allá del y = 0 - hecho
	method posicionSiguiente(posicion) = game.at(posicion.x(),0.max(posicion.down(1).y()))

    method siguiente(posicion) =  posicion.down(1)
}

object haciaLaDerecha {
	// TODO: saliendo por el borde derecho se da la vuelta a la manzana
    
	method posicionSiguiente(posicion) {
        if(posicion.right(1).x() > config.anchoMaximo()-1){
           return game.at(0,posicion.y())
        } else {
            return posicion.right(1)
        }
    }

    method siguiente(posicion) =  posicion.right(1)
}

object haciaLaIzquierda {
	// TODO: saliendo por el borde izquierdo se da la vuelta a la manzana
	method posicionSiguiente(posicion) {
         if(posicion.left(1).x() < 0 ){
           return game.at(config.anchoMaximo()-1,posicion.y())
        } else {
            return posicion.left(1)
        }
    }

    method siguiente(posicion) =  posicion.left(1)
}