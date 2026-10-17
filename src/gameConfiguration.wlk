import src.barrasAviso.*
import wollok.game.*

//dependecias relacionadas al juego en si (se pueden separar mas qsy)
import parrilla.*
import asador.*
import carnes.*
import cosoParaAgarrarMP.*
import sarten.*
import tablaDeCortar.*
import movimientos.*
import pedidos.*
import mesaDeEntrega.*


//dependencia utils
import animaciones.*
import azar.* 


object config {
  method alturaMaxima() = 12 
  method anchoMaximo() = 20
  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) esta en 20s para mi es poco
  method tiempoCambioFuego() = 20000

  //asado de prueba
  const unAsado = new Asado(posicionEnSuelo = game.at(2,2))
  //chori de prueba
  const unChori = new Chorizo(posicionEnSuelo = game.at(2,3))
  //tira de asado de prueba
  const unaTira = new TiraAsado()
  
  


  method configurarJuego(){
		self.configurarVentana()
    self.agregarVisuales()
    self.configurarColisiones()
    self.configurarParrilla()
    self.configurarFuego()
    self.configurarAnimacion()
    self.configurarAcciones()
    
    
    //agregar aca todo lo que sea necesario para iniciar el juego
  }

  method configurarVentana(){
		game.title("Grupo: GordosCompu | Nombre de jueguito")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
    game.cellSize(48) //tamanio de las celdas 
		//game.boardGround("image.png") //descomentar cuando tengamos una imagen de fondo
	}

  method agregarVisuales(){
    game.addVisual(parrilla)
    game.addVisual(mesaEntrega)
    game.addVisual(unAsado)
    game.addVisual(unChori)
    game.addVisual(unaTira)
    game.addVisual(asador)
    game.addVisual(listadoPedidos)
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
  }


  // aca estan las acciones que puede hacer el asador, cualquier accion hecha con una tecla por el asador deberia estar aca
  method configurarAcciones(){
		
    //movimiento 
    keyboard.up().onPressDo({asador.direccion(haciaArriba) movimiento.mover(asador, haciaArriba)})
		keyboard.down().onPressDo({asador.direccion(haciaAbajo) movimiento.mover(asador, haciaAbajo) })
		keyboard.left().onPressDo({asador.direccion(haciaLaIzquierda) movimiento.mover(asador, haciaLaIzquierda) })
		keyboard.right().onPressDo({asador.direccion(haciaLaDerecha) movimiento.mover(asador, haciaLaDerecha) })
    
    // acciones del asador agarrar y soltar (con la e deberia poder sacar carnes del dispenser)
    keyboard.e().onPressDo({ asador.agarrar() })
    keyboard.q().onPressDo({asador.ponerCarne()})
    keyboard.q().onPressDo({asador.entregar()})
    keyboard.q().onPressDo({ asador.soltar()})

    //acciones del asador para poner una carne en la parrilla 
    //keyboard.c().onPressDo({ asador.ponerCarne()})
    //Ahora es con la q
    

    //acion del asador para avivar el fuego
    keyboard.a().onPressDo({asador.avivarFuego()})
    
	}

  method configurarColisiones(){

    //deberia permitir al asador que al apretar ciertas teclas, le permita poner la carne en la parrilla, sacarla, avivar el fuego etc
    
    //Solo colisiones cuando necesitas producir un efecto que levanta un flag, ojo que no es onColideDo() y luego cuando ya no esta colisionando unDo
    // las bolas la flag queda levantada

    //agregar coliciones del tipo, carne con parrilla, el asador con las esquinas, el asador con los items etc ...  

	}

  //le dice a la parrilla que cocine la carne cada 1 segundo 
  method configurarParrilla(){
    game.tick(1000, {parrilla.asar()}, true).start()
  }

  //cada x segundos le dice a la parrilla que se apague un poco, va al fuego anterior
  method configurarFuego() {
    game.tick( self.tiempoCambioFuego(), {parrilla.fuego(parrilla.fuego().anterior())},true).start()
  }

  //aca hay polimorfismo -> animaciones de 8 frames
  method configurarAnimacion(){
    game.tick(300,{animaciones.aumentarContador()},true).start()
  }
}


//otra clase abstracta del pedido
class Pedido {
  const property plato
  method nombre(){
    plato.nombre()
  }
  method tiempo(){
    plato.tiempoCoccion() + 40
  }
}
//clase abstracta 
class Nivel { 
  
  // declaro todos los posibles platos a pedir por los niveles
  //borrar
  const chorizo = new Pedido(plato = new Chorizo(posicionEnSuelo = game.at(2,3)))
  const asado = new Pedido(plato = new Asado(posicionEnSuelo = game.at(2,3)))
  //metodo abstracto -- que deberia contener una lista de los posibles pedidos
  method listaPedidosPosibles()

  //la frecuencia con la que los pedidos se agregan a la lista
  method frecuenciaPedidos()

  //tiene que agarrar un nuevo pedido al azar de la lisra de pedidos 
  method siguientePedido() = self.listaPedidosPosibles().get(azar.numeroEntre(0, self.listaPedidosPosibles().size() -1))
  

  //agrega el pedido elegido al azar a la lista de pedidos 
  method agregarPedidoAListaDePedidos(){
    listadoPedidos.tomarPedido(self.siguientePedido())
  }
  
  

  //configura la velocidad con la que los pedidos se agregan a la lista
  method configurarFrecuenciaPedidos(){
    game.tick(self.frecuenciaPedidos(),{self.agregarPedidoAListaDePedidos()},true).start()
  }
}