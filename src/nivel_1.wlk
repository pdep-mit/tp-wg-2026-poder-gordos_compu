import src.superClaseChad.*
import eventos.*
import platos.*
import pedidos.*
import gameConfiguration.*
import carnes.*


object nivel1Facil inherits Nivel {
    //dos minutos de duracion x nivel 
    override method duracionNivel() = 120
    //cada 12 ssegundos
    override method frecuenciaPedidos() = 12000

    override method cantidadPuntosParaPasar() = 150

    //aca van todos los pedidos posibles para el nivel uno primero declarados por fuera
    override method listaPedidosPosibles() = [platoAsado, platoChori]

    //aca van los eventos posibles
    override method eventosPosibles() = [vientoFacil]

    override method agregarVisuales(){
        super()
        game.addVisual(puntosRequeridosFacil)
    }
}

object nivel1Dificil inherits Nivel{
    //100 segundos de duracion del nivel
    override method duracionNivel() = 100
    
    //cada 10 ssegundos
    override method frecuenciaPedidos() = 10000

    override method cantidadPuntosParaPasar() = 220

    //aca van todos los pedidos posibles para el nivel uno primero declarados por fuera
    override method listaPedidosPosibles() = [platoAsado, platoChori]

    //aca van los eventos posibles
    override method eventosPosibles() = [vientoDificil]

    override method agregarVisuales(){
        super()
        game.addVisual(puntosRequeridosDificil)
    }

}

object puntosRequeridosFacil inherits Chad {
    method image() = "puntos_requeridos_150.png"
    method position() = game.at(18,10)
}

object puntosRequeridosDificil inherits Chad {
    method image() = "puntos_requeridos_220.png"
    method position() = game.at(18,10)
}