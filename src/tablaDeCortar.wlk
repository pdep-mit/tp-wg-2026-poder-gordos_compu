import wollok.game.*
import superClaseChad.*
import elementosInvisibles.*


object tablaDeCortar inherits Chad {
    method image() = "tabla_cortar.png"
    method position()= game.at(10, 4)
    override method esSolido() = true

    method celdaActual() = self.position()

    method initialize() {
        game.addVisual(self)
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = -1))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = -2))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = -3))
        game.addVisual(new ElementoAuxiliar(duenio = self,desplazamientoX = 0, desplazamientoY = -4))
       
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