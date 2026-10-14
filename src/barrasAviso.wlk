import wollok.game.*
import carnes.*
import mesaDeEntrega.*

class BarraProgreso {
    var property carneActual = noCarne
    //serian los puntos que debe de superar la carne para cambiar de barra de progreso 
    const listaPorcentajes = [1, 50, 75, 100]

    //la posicion depende de la de la carne (se puede modificar para que aparezca la barra luego)
    method position () = carneActual.position().down(1) 
    
    method esAgarrable() = false
    method esParrilla() = false

    method image() = "barra_progreso_" + self.calcularProgreso() + ".png"

    //en base al estado de la carne se calcula la imagen que debe mostrar el progreso de la misma
    method calcularProgreso(){
        
        const estadoCarne = carneActual.comoAndas()

        //antes de hacer cosas verificamos que no se haya quemado
        if(carneActual.seQuemo()){
            //valor intermedio hasta tener la imagen del triangulo de alerta 
            return 5
        }

        //quiero una nueva lista que contenga unicamente los elementos que sean menores al estado de la carne (queriendo decir que ya paso x esa etapa de progreso)
        const listaPorcentajeReal = listaPorcentajes.filter({porcentaje => estadoCarne >= porcentaje})

        //devuelve la cantidad de porcentajes que ya paso la carne
        return listaPorcentajeReal.size()

    } 
}

// le agrego una barra indicadora de tiempo restante a cada elemento de nuestra lista de pedidos pendientes.
class BarraPedido
{
    const listaPorcentajes = [0, 25, 50, 75, 100]
    const elementoActual
    method duracionInicial() = elementoActual.tiempo()
    method duracionActual() = self.duracionInicial() - segundosTranscurridos
    var property segundosTranscurridos = 0 

    method calcularProgreso() {
        return listaPorcentajes.count({porcentaje => self.porcentajeTiempo() >= porcentaje})
        }

    method position() = elementoActual.position().down(1)

    method acortarTiempo(){
            game.onTick(1000, "calcularProgreso", {self.aniadirSegundos()})
        }

    method aniadirSegundos() {
        segundosTranscurridos = (segundosTranscurridos + 1).min(self.duracionInicial())
    }
    
    method image() = "barra_progreso_" + self.calcularProgreso() + ".png"
    
    method porcentajeTiempo()
    {
        return ( self.duracionActual()* 100) / self.duracionInicial()
    }
}