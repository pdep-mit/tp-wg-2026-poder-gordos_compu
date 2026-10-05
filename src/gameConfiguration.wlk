import wollok.game.*

//dependecias relacionadas al juego en si (se pueden separar mas qsy)
import parrilla.*
import asador.*
import carnes.*
import comensales.*
import cosoParaAgarrarMP.*
import sarten.*
import tablaDeCortar.*


object config {
  method alturaMaxima() = 12 
  method anchoMaximo() = 20
  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) esta en 20s para mi es poco
  method tiempoCambioFuego() = 20000

  //asado de prueba
  const unAsado = new Asado()


method configurarJuego(){
		self.configurarVentana()
        self.agregarVisuales()
        self.configurarColisiones()
        self.configurarParrilla()
        self.configurarFuego()
        self.configurarAnimacionParrilla()
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
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
  }

  method configurarColisiones(){
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
}