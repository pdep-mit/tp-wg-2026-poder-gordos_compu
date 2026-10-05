import wollok.game.*
import carnes.*

class BarraProgreso {
    var property carneActual = noCarne
    //serian los puntos que debe de superar la carne para cambiar de barra de progreso 
    const listaPorcentajes = [1, 50, 75, 100]

    //la posicion depende de la de la carne (se puede modificar para que aparezca la barra luego)
    method position () = carneActual.position().down(1) 

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
