import wollok.game.*
import carnes.*

class BarraProgreso {
    var property carneActual = noCarne
    const progresoActual = 0

    method image() = "barra_progreso_" + progresoActual

    method quieroSaberTuEstadoPapi(){
        const estadoCarne = carneActual.comoAndas()
        //tenemos 4 estados para la carne 

        //si el estado es menor a un 1/4 entonces 1
        //si el estado es menor a un 2/4 entonces 2
        //si el estado es menor a un 3/4 entonces 3
        //si el estado es igual o mayor al tiempo de coccion => 4 es q esta listo 
    }
}
