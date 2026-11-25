import src.carnes.*
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
        // Le pedimos a la carga que valide si se puede cortar, sino devuelve error.
        carga.validarSiEsCortable()
        
        carga.dejarEn(self) 
    }

    method loQueTengoEncima() = game.getObjectsIn(self.position()).filter({ obj => obj != self })
        
    method cortar() {
        if (not self.tablaLibre()) {
        self.loQueTengoEncima().first().intentarCortarseEn(self)
        }
    }

    method terminoElEsfuerzo() {
     self.loQueTengoEncima().first().serCortada(self)
    }

    method posicionBarra() = self.position().down(1)

    override method dejarAgarrarPor(parrillero){
        if(!self.tablaLibre()){
            self.loQueTengoEncima().first().dejarAgarrarPor(parrillero)
        }
    }

    method tablaLibre() = self.loQueTengoEncima().isEmpty()

    method reiniciarEsfuerzo() {
        barraEsfuerzo.reiniciar()
    }

    method reiniciar(){
        self.reiniciarEsfuerzo()
    }

    method esforzar(){ 
        barraEsfuerzo.esforzar()
    }

    override method usar(){
        self.cortar()
    }

    method esfuerzoRequerido() = 4
}