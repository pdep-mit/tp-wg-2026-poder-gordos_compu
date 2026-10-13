import mesaDeEntrega.*
import gameConfiguration.* 

object nivel1 inherits Nivel {
    //cada 10 ssegundos
    override method frecuenciaPedidos() = 10000
    
    //aca van todos los pedidos posibles para el nivel uno 
    override method listaPedidosPosibles() = []
}