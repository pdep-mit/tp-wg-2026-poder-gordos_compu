import wollok.game.*
import superClaseChad.*
import elementosInvisibles.*
import barrasAviso.*

object tablaDeCortar inherits Chad {
    const barraEsfuerzo = new BarraEsfuerzo(duenio = self)
    
    method image() = "tabla_cortar.png"
    method position() = game.at(10, 4)
    override method esSolido() = true

    method celdaActual() = self.position()

    // Agregamos un método para agregar la tabla y sus elementos auxiliares cuando arranque el nivel
    method agregarVisuales() {
        game.addVisual(self)
       
        game.addVisual(barraEsfuerzo)
    }

    override method recibir(carga) {
        if(not self.tablaLibre()){
            self.error("la tabla esta ocupada")
        }
        carga.dejarEn(self) 
    }

    method loQueTengoEnsima() = game.getObjectsIn(self.position()).filter({ obj => obj != self })
        
    override method cortar() {
        if (not self.tablaLibre()) {
        barraEsfuerzo.esforzar()
        }
    }

    method terminoElEsfuerzo() {
     self.loQueTengoEnsima().first().serCortada(self)
    }

    method posicionBarra() = self.position().down(1)

    override method dejarAgarrarPor(parrillero){
        if(!self.tablaLibre()){
            self.loQueTengoEnsima().first().dejarAgarrarPor(parrillero)
        }
    }

    method tablaLibre() = self.loQueTengoEnsima().isEmpty()

    method reiniciarEsfuerzo() {
        barraEsfuerzo.reiniciar()
    }
}