import wollok.game.*

//dependecias relacionadas al juego en si (se pueden separar mas qsy)
import parrilla.*
import asador.*
import carnes.*
import comensales.*
import cosoParaAgarrarMP.*
import sarten.*
import tablaDeCortar.*
import movimientos.*

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
    self.configurarAnimacionParrilla()
    self.configurarAcciones()
    self.configurarAnimacionChori()  
    //agregar aca todo lo que sea necesario para iniciar el juego

    //adicion temporal
      
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
    keyboard.up().onPressDo({ movimiento.mover(asador, haciaArriba) asador.cambiarDireccion(3) })
		keyboard.down().onPressDo({ movimiento.mover(asador, haciaAbajo) asador.cambiarDireccion(0) })
		keyboard.left().onPressDo({ movimiento.mover(asador, haciaLaIzquierda) asador.cambiarDireccion(1) })
		keyboard.right().onPressDo({ movimiento.mover(asador, haciaLaDerecha) asador.cambiarDireccion(2) })

    //agarrar cosas

    //dejar cosas
	}

  method configurarColisiones(){

    //deberia permitir al asador que al apretar ciertas teclas, le permikta poner la carne en la parrilla, sacarla, avivar el fuego etc
    //game.onCollideDo(parrilla,{})

    //agregar coliciones del tipo, carne con parrilla, el asador con las esquinas, el asador con los items etc ...  
	}

  //le dice a la parrilla que cocine la carne cada 1 segundo 
  method configurarParrilla(){
    game.onTick(1000, "cocinarCarne", {parrilla.asar()})
  }

  //cada x segundos le dice a la parrilla que se apague un poco, va al fuego anterior
  method configurarFuego() {
    game.onTick( self.tiempoCambioFuego(),"cambioFuego", {parrilla.fuego(parrilla.fuego().anterior())})
  }

  method configurarAnimacionParrilla(){
    game.onTick(300, "animacionFuego",{parrilla.siguienteAnimacion()})
  }

  //esto lo podriamos modificar si tenemos mas animaciones x carne x ahora solo el chori (tmb es un monton para todas las carnes xd)
  method configurarAnimacionChori() {
    game.onTick(300,"animacionChori",{unChori.siguienteAnimacion()})
  }
}