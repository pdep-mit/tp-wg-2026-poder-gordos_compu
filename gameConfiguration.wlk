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
  method alturaMaxima() = 10 
  method anchoMaximo() = 10

method configurarJuego(){
		self.configurarVentana()
        self.agregarVisuales()
        self.configurarColisiones()
        //agregar aca todo lo que sea necesario para iniciar el juego 
    }

  method configurarVentana(){
		game.title("Grupo: ... | Nombre de jueguito")
		game.height(self.alturaMaxima())
		game.width(self.anchoMaximo())
		game.boardGround("")
	}

    method agregarVisuales(){
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
    }

    method configurarColisiones(){
        //agregar coliciones del tipo, carne con parrilla, el asador con las esquinas, el asador con los items etc ...  
	}
}