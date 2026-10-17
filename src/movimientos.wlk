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
        const cosasEnfrente = game.getObjectsIn(personajeLibre.celdaDeEnfrente())
        //Revisamos si en frente hay objetos solidos
        const cosasSolidasEnFrente = cosasEnfrente.filter({obj => obj.esSolido()})
        const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
        //Si la en frente no hay solidos entonces avanza, de no ser asi no avanza a la nueva posicion :p bastante logico
        if(cosasSolidasEnFrente.isEmpty())
        {
            personajeLibre.position(nuevaPosicion)
        }
    }
}


    //LEGACY CODE borrenlo cuando hayan visto que no les rompe nada el nuevo codigo, quizas algun test
    //     const nuevaPosicion = direccion.posicionSiguiente(personajeLibre.position())
    //      // Si la nueva posición coincide con la parrilla, no se mueve
    //      //NO HACE FALTA USAR ON COLIDE PARA ESTO, ON COLDIDE sirve para otra cosa! Generar efecto atraves de levantar un flag! Para esto es pesimo (creanme lo intente).
    //      //ojo aca podemos usar quizas coliders, comprobamos todas las posiciones de los coliders que no sean la misma que la nueva posicion
    // if (nuevaPosicion != parrilla.position() && nuevaPosicion != parrilla1.position() && nuevaPosicion != mesaEntrega.position() && nuevaPosicion != mesaDeEntrega1.position() 
    // && nuevaPosicion != mesaDeEntrega2.position() && nuevaPosicion != mesaDeEntrega3.position()) { // ESTO HAY QUE REVISARLO ESTA MUY MUY RANCIO
    //   personajeLibre.position(nuevaPosicion)
    //     }
    // }

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