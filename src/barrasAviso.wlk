import wollok.game.*
import carnes.*
import pedidos.*
import src.superClaseChad.*
import animaciones.*

class BarraProgreso inherits Chad {
    var property carneActual = noCarne
    method esAgarrable() = false
    method esParrilla() = false
    

    //serian los puntos que debe de superar la carne para cambiar de barra de progreso 
    const listaPorcentajes = [1, 50, 75, 100]

    //la posicion depende de la de la carne (se puede modificar para que aparezca la barra luego)
    method position () = carneActual.position().down(1) 
    
    method image() = "barra_progreso_" + self.calcularProgreso() + ".png"

    //en base al estado de la carne se calcula la imagen que debe mostrar el progreso de la misma
    method calcularProgreso(){
        
        const estadoCarne = carneActual.comoAndas()

        //cuando esta en el rango de cocida le tenemos que avisar que se esta por quemar
        if(carneActual.seEstaPorQuemar()){
            return animaciones.siguienteFrame(2) + 8
        }

        if(carneActual.seQuemo()){
            return 10
        }

        //quiero una nueva lista que contenga unicamente los elementos que sean menores al estado de la carne (queriendo decir que ya paso x esa etapa de progreso)
        const listaPorcentajeReal = listaPorcentajes.filter({porcentaje => estadoCarne >= porcentaje})

        //devuelve la cantidad de porcentajes que ya paso la carne
        return listaPorcentajeReal.size()

    } 

    //delegamos pa 
    override method dejarAgarrarPor(parrillero){
        carneActual.dejarAgarrarPor(parrillero)
    }
}

// le agrego una barra indicadora de tiempo restante a cada elemento de nuestra lista de pedidos pendientes.
class BarraPedido inherits Chad
{
    const listaPorcentajes = [0, 25, 50, 75, 100]
    const elementoActual
    var property segundosTranscurridos = 0
    const nombreEvento = "calcularProgreso" + self.identity()

    method duracionInicial() = elementoActual.tiempo()

    method duracionActual() = self.duracionInicial() - segundosTranscurridos

    method calcularProgreso() {
        return listaPorcentajes.count({porcentaje => self.porcentajeTiempo() >= porcentaje})
        }

    method position() = elementoActual.position().down(1)

    method acortarTiempo(){
            game.onTick(1000, nombreEvento, {self.aniadirSegundos()})
        }

    method aniadirSegundos() {
        segundosTranscurridos = (segundosTranscurridos + 1).min(self.duracionInicial())
    }   
    
    method image() = "barra_progreso_" + self.calcularProgreso() + ".png"
    
    method porcentajeTiempo()
    {
        return ( self.duracionActual()* 100) / self.duracionInicial()
    }

    // freno el timer individual de cada elemento por separado usando el
    // self.identity() en el nombre de calcularProgreso
    method detener() {
		game.removeTickEvent(nombreEvento)
	}
}
