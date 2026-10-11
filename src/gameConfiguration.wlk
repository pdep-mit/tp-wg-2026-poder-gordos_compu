import wollok.game.*

//dependecias relacionadas al juego en si (se pueden separar mas qsy)
import parrilla.*
import asador.*
import carnes.*
import cosoParaAgarrarMP.*
import sarten.*
import tablaDeCortar.*
import movimientos.*

//dependencia utils
import animaciones.*


object config {
  method alturaMaxima() = 12 
  method anchoMaximo() = 20
  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) esta en 20s para mi es poco
  method tiempoCambioFuego() = 20000

  //asado de prueba
  const unAsado = new Asado()
  //chori de prueba
  const unChori = new Chorizo()
  
  


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
		//game.boardGround("nombreDeImagen.png") //descomentar cuando tengamos una imagen de fondo
	}

  method agregarVisuales(){
    game.addVisual(parrilla)
    game.addVisual(unAsado)
    game.addVisual(unChori)
    game.addVisual(asador)
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
  }


  // aca estan las acciones que puede hacer el asador, cualqueir accion hecha con una tecla por el asador deberia estar aca
  method configurarAcciones(){
		
    //movimiento 
    keyboard.up().onPressDo({asador.direccion(haciaArriba) movimiento.mover(asador, haciaArriba) asador.cambiarDireccion(3) })
		keyboard.down().onPressDo({asador.direccion(haciaAbajo) movimiento.mover(asador, haciaAbajo) asador.cambiarDireccion(0) })
		keyboard.left().onPressDo({asador.direccion(haciaLaIzquierda) movimiento.mover(asador, haciaLaIzquierda) asador.cambiarDireccion(1) })
		keyboard.right().onPressDo({asador.direccion(haciaLaDerecha) movimiento.mover(asador, haciaLaDerecha) asador.cambiarDireccion(2) })
    
    // acciones del asador agarrar y soltar
    keyboard.e().onPressDo({ asador.agarrar() })
    keyboard.q().onPressDo({ asador.soltar()})

    //acciones del asador para poner una carne en la parrilla 
    keyboard.c().onPressDo({ asador.ponerCarne()})

    //acion del asador para avivar el fuego
    
	}

  method configurarColisiones(){

    //deberia permitir al asador que al apretar ciertas teclas, le permikta poner la carne en la parrilla, sacarla, avivar el fuego etc
    //game.onCollideDo(parrilla,{})

    //agregar coliciones del tipo, carne con parrilla, el asador con las esquinas, el asador con los items etc ...  

    // colisiones de comensales al recibir los platos (por ahora solo el tio)
    
	}

  //le dice a la parrilla que cocine la carne cada 1 segundo 
  method configurarParrilla(){
    game.onTick(1000, "cocinarCarne", {parrilla.asar()})
  }

  //cada x segundos le dice a la parrilla que se apague un poco, va al fuego anterior
  method configurarFuego() {
    game.onTick( self.tiempoCambioFuego(),"cambioFuego", {parrilla.fuego(parrilla.fuego().anterior())})
  }

  //aca hay polimorfismo -> animaciones de 8 frames
  method configurarAnimacion(){
    game.onTick(300, "animaciones",{animaciones.aumentarContador()})
  }
}