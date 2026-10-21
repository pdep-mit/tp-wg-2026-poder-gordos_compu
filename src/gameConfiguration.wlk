import src.superClaseChad.*
import src.mesaDeCorte.*
import src.barraDePedidos.*
import src.barrasAviso.*
import wollok.game.*
import menu.*

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
import src.nivel_1.*


object config {
  var property nivelActual = nivel1 
  
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

//temporales
object cronometro inherits Chad {
  method position() = game.at(18, 0)
  method textColor() = "FFFFFFFF"
  method text() = config.nivelActual().tiempoRestante().toString()
}

object contadorAplausos inherits Chad {
  method position() = game.at(1, 0)
  method textColor() = "FFFFFFFF"
  method text() = config.nivelActual().aplausos().toString()
}

object iconoAplauso inherits Chad {
  method position() = game.at(0, 0)
  method image() = "aplausos.png"
}

//clase abstracta 
class Nivel { 
  var property tiempoTranscurrido = 0
  

  method arrancarNivel(){
    config.nivelActual(self)
    self.agregarVisuales()
    //self.configurarColisiones()
    self.configurarAcciones()
    self.configurarFrecuenciaPedidos()
    self.configurarNivel()
    self.configurarParrilla()
    self.configurarFuego()
    self.configurarAnimacion()
  }

  method reiniciarNivel() {
    // 1. Limpiamos visuales, ticks y listeners del motor
    game.clear()

    // 2. Reseteamos métricas del nivel
    tiempoTranscurrido = 0
    aplausos = 0

    // 3. Reseteamos el estado de los objetos a nuevo
    asador.reiniciar()
    listadoPedidos.reiniciar()
    parrilla.reiniciar()

    // 4. Volvemos al menú principal
    menuPrincipal.iniciar()
  }
  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) esta en 20s para mi es poco
  method tiempoCambioFuego() = 20000

  //  dispensers
  const unDispenser = new DispensadorAsado()
  const dosDispenser = new DispensadorChori()

  method duracionNivel()
  method tiempoRestante() = 0.max(self.duracionNivel() - self.tiempoTranscurrido())
  
  //esto puede cambiar pero para mi los aplausos capaz pueden ser del nivel no del asador
  var property aplausos = 0 

  method cantidadPuntosParaPasar() 

  method aumentarTiempo(){
    tiempoTranscurrido += 1
  } 

  

  //metodo abstracto -- que deberia contener una lista de los posibles pedidos
  method listaPedidosPosibles()

  //la frecuencia con la que los pedidos se agregan a la lista
  method frecuenciaPedidos()

  //tiene que agarrar un nuevo pedido al azar de la lisra de pedidos 
  method siguientePedido() = self.listaPedidosPosibles().get(azar.numeroEntre(0, self.listaPedidosPosibles().size() -1))
  

  //agrega el pedido elegido al azar a la lista de pedidos 
  method agregarPedidoAListaDePedidos(){
    if(listadoPedidos.pedidos().size() < 5)
    {
      listadoPedidos.tomarPedido(new ElementoLista(pedidoActual = self.siguientePedido()))
    }
  }
  
  method configurarNivel(){ 
    game.tick(1000,{

    //Deja de aumentar el tiempo si se termino el juego
    if (!self.terminoElJuego()) {
      //aumenta en un segundo el tiempo restante
      self.aumentarTiempo()
    
      if(self.terminoElJuego()){
        cartel.mostrarCartel(aplausos, self.cantidadPuntosParaPasar())
        //deberia mandarle un mensaje a algun cartel que en base a los aplausos del asador decida si gano o perdio 
      }
      }
    }, false).start()
  }
  //Como estaba antes saltaba terminar el juego siempre que el tiempo NO sea 0, ahora lo arregle
  method terminoElJuego() = self.tiempoRestante() == 0

  //configura la velocidad con la que los pedidos se agregan a la lista
  method configurarFrecuenciaPedidos(){
    game.tick(self.frecuenciaPedidos(),{ if (!self.terminoElJuego()) self.agregarPedidoAListaDePedidos() },false).start()
  }

  method agregarVisuales(){
    mesaCorte.agregarVisuales()
    tablaDeCortar.agregarVisuales()
    game.addVisual(unDispenser)
    game.addVisual(dosDispenser)
    parrilla.agregarVisuales()
    game.addVisual(barraDePedidos)
    mesaEntrega.agregarVisuales()
    game.addVisual(asador)
    game.addVisual(listadoPedidos)
    game.addVisual(cronometro)
    game.addVisual(contadorAplausos)
    game.addVisual(iconoAplauso)
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
  }


  // aca estan las acciones que puede hacer el asador, cualquier accion hecha con una tecla por el asador deberia estar aca
  method configurarAcciones(){
    
    //movimiento 
    keyboard.up().onPressDo({ if (!self.terminoElJuego()) { asador.direccion(haciaArriba) movimiento.mover(asador, haciaArriba) } })
    keyboard.down().onPressDo({ if (!self.terminoElJuego()) { asador.direccion(haciaAbajo) movimiento.mover(asador, haciaAbajo) } })
    keyboard.left().onPressDo({ if (!self.terminoElJuego()) { asador.direccion(haciaLaIzquierda) movimiento.mover(asador, haciaLaIzquierda) } })
    keyboard.right().onPressDo({ if (!self.terminoElJuego()) { asador.direccion(haciaLaDerecha) movimiento.mover(asador, haciaLaDerecha) } })
    
    //acciones del asador agarrar y soltar (ahora puede poner una carne con la q y no le deja poner una carne si esta fuera de la pantalla)
    keyboard.e().onPressDo({ if (!self.terminoElJuego()) asador.agarrar() })
    keyboard.q().onPressDo({ if (!self.terminoElJuego()) asador.soltar() })


    //acion del asador para avivar el fuego
    keyboard.a().onPressDo({ if (!self.terminoElJuego()) asador.avivarFuego() })
    
    //accion del asador para cortar una carne
    keyboard.c().onPressDo({ if (!self.terminoElJuego()) asador.cortar() })

    //accion para reiniciar nivel cuando termine
    keyboard.r().onPressDo({ if (self.terminoElJuego()) self.reiniciarNivel() })
  }

  // method configurarColisiones(){

  //   //deberia permitir al asador que al apretar ciertas teclas, le permita poner la carne en la parrilla, sacarla, avivar el fuego etc
    
  //   //Solo colisiones cuando necesitas producir un efecto que levanta un flag, ojo que no es onColideDo() y luego cuando ya no esta colisionando unDo
  //   // las bolas la flag queda levantada

  //   //agregar coliciones del tipo, carne con parrilla, el asador con las esquinas, el asador con los items etc ...  

  // }
  
  //le dice a la parrilla que cocine la carne cada 1 segundo 
  method configurarParrilla(){
    game.tick(1000, { if (!self.terminoElJuego()) parrilla.asar() }, true).start()
  }

  //cada x segundos le dice a la parrilla que se apague un poco, va al fuego anterior
  method configurarFuego() {
    game.tick( self.tiempoCambioFuego(), { if (!self.terminoElJuego()) parrilla.apagarPoco() },false).start()
  }

  method configurarAnimacion(){
    game.tick(300,{ if (!self.terminoElJuego()) animaciones.aumentarContador() },true).start()
  }

  method sumarPuntos(puntos){
    aplausos += puntos
  }

  method restarPuntos(puntos){
    aplausos -= puntos
  }
}
// Clase para cada segmento del fondo
class SegmentoFondoTexto inherits Chad {
  const property desplazamientoX = 0

  method position() = cartel.position().down(1).right(desplazamientoX)
  method image() = "fondoNegro.png" 
  override method esSolido() = false
}

// Los 3 bloques que forman la tira ancha
object fondoIzquierda inherits SegmentoFondoTexto(desplazamientoX = -1) {}
object fondoCentro    inherits SegmentoFondoTexto(desplazamientoX = 0) {}
object fondoDerecha   inherits SegmentoFondoTexto(desplazamientoX = 1) {}

// El objeto que dibuja el texto
object cartelTexto inherits Chad {
  var property mensaje = ""

  
  method position() = fondoCentro.position()
  override method esSolido() = false

  method text() = mensaje
  method textColor() = "FFFFFFFF"
}

object cartel inherits Chad {
  var property image = "cartel_victoria.png"
  var property puntosObtenidos = 0

  method position() = game.at(6, 5)
  override method esSolido() = false

  method mostrarCartel(puntos, cantidadPuntosParaPasar) {
    puntosObtenidos = puntos

    if (puntos >= cantidadPuntosParaPasar) {
      self.mostrarCartelVictoria(puntos)
    } else {
      self.mostrarCartelDerrota(puntos)
    }

    // 1. Cartel principal
    if (!game.hasVisual(self)) {
      game.addVisual(self)
    }

    // 2. Tira de 3 celdas de fondo (capa inferior)
    if (!game.hasVisual(fondoIzquierda)) { game.addVisual(fondoIzquierda) }
    if (!game.hasVisual(fondoCentro))    { game.addVisual(fondoCentro) }
    if (!game.hasVisual(fondoDerecha))   { game.addVisual(fondoDerecha) }

    // 3. Texto por encima (capa superior)
    if (!game.hasVisual(cartelTexto)) {
      game.addVisual(cartelTexto)
    }
  }

  method mostrarCartelVictoria(puntos) {
    image = "cartel_victoria.png"
    cartelTexto.mensaje("VICTORIA! - " + puntos.toString() + "\n pts | [R] Reiniciar")
  }

  method mostrarCartelDerrota(puntos) {
    image = "cartel_derrota.png"
    cartelTexto.mensaje("DERROTA! - " + puntos.toString() + "\n pts | [R] Reiniciar")
  }
}