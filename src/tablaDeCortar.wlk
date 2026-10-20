import wollok.game.*
import superClaseChad.*

object tablaDeCortar inherits Chad {
    method image() = "tabla_cortar.png"
    method position()= game.at(10, 4)
    override method esSolido() = true

    method celdaActual() = self.position()

    method initialize() {
        game.addVisual(self)
    }

    override method recibir(carga) {
        carga.dejarEn(self) 
        carga.serCortada(self) 
    }

    override method dejarAgarrarPor(parrillero) {
        const objetosEnCelda = game.getObjectsIn(self.position())
        const cosasEncima = objetosEnCelda.filter({ obj => obj != self })
        
        if (!cosasEncima.isEmpty()) {
            cosasEncima.first().dejarAgarrarPor(parrillero)
        } else {
            game.say(parrillero, "La tabla está vacía")
        }
    }
}