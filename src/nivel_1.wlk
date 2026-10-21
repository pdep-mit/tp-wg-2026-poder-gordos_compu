import platos.*
import pedidos.*
import gameConfiguration.*
import carnes.*


object nivel1 inherits Nivel {
    //dos minutos de duracion x nivel 
    //override method duracionNivel() = 120
    override method duracionNivel() = 3 // <-- Dura 3 segundos para probar
    //cada 12 ssegundos
    override method frecuenciaPedidos() = 12000

    override method cantidadPuntosParaPasar() = 200

    //aca van todos los pedidos posibles para el nivel uno primero declarados por fuera
    override method listaPedidosPosibles() = [platoAsado, platoChori]
}