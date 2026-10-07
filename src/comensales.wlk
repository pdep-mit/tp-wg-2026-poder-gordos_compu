import asador.*
import wollok.game.*

//lo mismo que con las carnes, podriamos usar herencia pero ni idea pa asi que hacemos clases para los comensales

class Pedido {
  var property nombre
  const property tiempo
  var property entregado = false
}

class Tio {
    const imagenActual = "comensalEjemplo.png"
    // variable temporal, cambiar la implementacion en proximas entregas
    const property esCarne = false
    method image() = imagenActual
    var property position = game.at(7, 7)
    const property pedidoComensal = new Pedido(nombre = "chori",tiempo = 15)
    
    method pedir(){
        game.say(self," me gustaria un " + pedidoComensal.nombre() + " y lo quiero en "+pedidoComensal.tiempo()+ " segundos por favor")
        asador.tomarPedido(pedidoComensal)
    }
    method decir(mensaje){
        game.say(self,mensaje)
    }
    method recibirPedido(plato)
    {
        if(plato.nombre() == pedidoComensal.nombre())
        {
            self.decir("Muy Rico")
        }
        else
        {
            self.decir("Esto no es lo que pedi")
        }
    }
}

class Padre{

}

class Madre{

}

class Hermanos {
  
}

class Hermana{
    
}

class Amigo {
    //para este tengo un pedido que si le dan una carne quemada diga "uhhhhh una mantequita amigo, (sonidos de la carne mas dura q comiste en tu vida)"
}