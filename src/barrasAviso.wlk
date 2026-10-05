import wollok.game.*
import carnes.*

class BarraProgreso {
    var property carneActual = noCarne

    method image() = carneActual.comoAndas().image()
}
