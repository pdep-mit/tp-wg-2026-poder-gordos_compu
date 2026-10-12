import mesaDeEntrega.*
import gameConfiguration.* 

object nivel1 inherits Nivel {
    //cada 5 ssegundos
    override method frecuenciaPedidos() = 5000
    
    //aca van todos los pedidos posibles para el nivel uno 
    override method listaPedidosPosibles() = []
}