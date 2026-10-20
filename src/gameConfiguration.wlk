import src.barraDePedidos.*
import src.barrasAviso.*
import wollok.game.*

//dependecias relacionadas al juego en si (se pueden separar mas qsy)
import parrilla.*
import asador.*
import carnes.*
import sarten.*
import tablaDeCortar.*
import movimientos.*
import pedidos.*
import mesaDeEntrega.*
import dispenser.*
import platos.*

//dependencia utils
import animaciones.*
import azar.* 


object config {
  method alturaMaxima() = 12 
  method anchoMaximo() = 20
  
  method configurarJuego(){
		self.configurarVentana()
     //agregar aca todo lo que sea necesario para iniciar el juego
  }

  method configurarVentana(){
		game.title("Grupo: GordosCompu | Nombre de jueguito")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
    game.cellSize(48) //tamanio de las celdas 
		game.boardGround("fondo.png")
	}

  //verifica que la celda este en el tablero 
  method esCeldaPermitida(celda)=
    celda.celdaActual().x().between(0, self.anchoMaximo() -1) and
    celda.celdaActual().y().between(0, self.alturaMaxima() - 2)  
    // esto no tiene sentido debido a que ya no se puede soltar la carne en el lugar del item fram
    //not (celda == parrilla.position() or celda == parrilla.position().right(1)) //Habria que revisar esto pero va por ahi aunque esta raro
}


//clase abstracta 
class Nivel { 
  
  method arrancarNivel(){
    self.agregarVisuales()
    self.configurarColisiones()
    self.configurarAcciones()
    self.configurarFrecuenciaPedidos()
    self.configurarNivel()
    self.configurarParrilla()
    self.configurarFuego()
    self.configurarAnimacion()
  }
  
  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) esta en 20s para mi es poco
  method tiempoCambioFuego() = 20000

  //  asado de prueba
  const unAsado = new Asado(posicionEnSuelo = game.at(2,4))
  //  chori de prueba
  const unChori = new Chorizo(posicionEnSuelo = game.at(2,3))
  //  tira de asado de prueba
  const unaTira = new TiraAsado()
  //  dispenser de prueba
  const unDispenser = new DispensadorAsado()
  
  method duracionNivel()
  var tiempoRestante = 0

  //esto puede cambiar pero para mi los aplausos capaz pueden ser del nivel no del asador
  var property aplausos = 0 

  method cantidadPuntosParaPasar() 

  method aumentarTiempo(){
    tiempoRestante += 1
  }  

  //metodo abstracto -- que deberia contener una lista de los posibles pedidos
  method listaPedidosPosibles()

  //la frecuencia con la que los pedidos se agregan a la lista
  method frecuenciaPedidos()

  //tiene que agarrar un nuevo pedido al azar de la lisra de pedidos 
  method siguientePedido() = self.listaPedidosPosibles().get(azar.numeroEntre(0, self.listaPedidosPosibles().size() -1))
  

  //agrega el pedido elegido al azar a la lista de pedidos 
  method agregarPedidoAListaDePedidos(){
    listadoPedidos.tomarPedido(new ElementoLista(pedidoActual = self.siguientePedido()))
  }
  
  method configurarNivel(){ 
    game.tick(1000,{

    //aumenta en un segundo el tiempo restante
    self.aumentarTiempo()
    
    if(self.terminoElJuego()){
      cartel.mostrarCartel(aplausos, self.cantidadPuntosParaPasar())
      //deberia mandarle un mensaje a algun cartel que en base a los aplausos del asador decida si gano o perdio 
    }
    }, false).start()
  }

  method terminoElJuego() = tiempoRestante >= self.duracionNivel()

  //configura la velocidad con la que los pedidos se agregan a la lista
  method configurarFrecuenciaPedidos(){
    game.tick(self.frecuenciaPedidos(),{self.agregarPedidoAListaDePedidos()},false).start()
  }

  method agregarVisuales(){
    game.addVisual(unDispenser)
    game.addVisual(parrilla)
    game.addVisual(barraDePedidos)
    game.addVisual(mesaEntrega)
    game.addVisual(unAsado)
    unAsado.mostrarParteInvisible()
    game.addVisual(unChori)
    unChori.mostrarParteInvisible()
    game.addVisual(unaTira)
    unaTira.mostrarParteInvisible()
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
    
    //acciones del asador agarrar y soltar (ahora puede poner una carne con la q y no le deja poner una carne si esta fuera de la pantalla)
    keyboard.e().onPressDo({ asador.agarrar() })
    keyboard.q().onPressDo({ asador.soltar()})


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
    game.tick( self.tiempoCambioFuego(), {parrilla.apagarPoco()},false).start()
  }

  method configurarAnimacion(){
    game.tick(300,{animaciones.aumentarContador()},true).start()
  }
}

object cartel{

  method mostrarCartel(puntos, cantidadPuntosParaPasar){
    if(puntos >= cantidadPuntosParaPasar){
      self.mostrarCartelVictoria()
    }
    else {
      self.mostrarCartelDerrota()
    }
  }

  method mostrarCartelVictoria(){}

  method mostrarCartelDerrota(){}
}
