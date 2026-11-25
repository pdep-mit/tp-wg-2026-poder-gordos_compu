import src.superClaseChad.*
import src.mesaDeCorte.*
import src.barraDePedidos.*
import src.barrasAviso.*
import wollok.game.*
import menu.*

//dependecias relacionadas al juego en si
import parrilla.*
import asador.*
import carnes.*
import tablaDeCortar.*
import movimientos.*
import pedidos.*
import mesaDeEntrega.*
import dispenser.*
import platos.*
import eventos.*

//dependencia utils
import animaciones.*
import azar.* 
import src.nivel_1.*
import pantallas.*


object config {
  var property nivelActual = nivel1Facil 
  
  method alturaMaxima() = 12 
  method anchoMaximo() = 20
  
  method configurarJuego(){
		self.configurarVentana()
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
}

//temporales -- LUCA ARREGLAME EL JUEGUITO
object cronometro inherits Chad {
  method position() = game.at(18, 0)
  method textColor() = "FFFFFFFF"
  method text() = config.nivelActual().tiempoRestante().toString()

  method image() = "fondoNegro.png" 
}

object contadorAplausos inherits Chad {
  method position() = game.at(1, 0)
  method textColor() = "FFFFFFFF"
  method text() = config.nivelActual().aplausos().toString()
  method image() = "fondoNegro.png" 
}

object iconoAplauso inherits Chad {
  method position() = game.at(0, 0)
  method image() = "aplausos.png"
}

//clase abstracta 
class Nivel { 
  var property tiempoTranscurrido = 0
  
  //el evento actual del nivel
  var eventoActual = despejado

  //los ticks del nivel 
  const reloj = game.tick(1000, { self.avanzarReloj() }, false)
  const agregarPedidosLista = game.tick(self.frecuenciaPedidos(), { self.agregarPedidoAListaDePedidos() }, false)
  const cocinarCarne = game.tick(1000, { parrilla.asar() }, true)
  const bajarFuego = game.tick(self.tiempoCambioFuego(), { parrilla.apagarPoco() }, false)
  const tiempoAnimaciones = game.tick(300, { animaciones.aumentarContador() }, true)

  method ticksDelNivel() = [reloj, agregarPedidosLista, cocinarCarne, bajarFuego, tiempoAnimaciones]

  method arrancarNivel(){
    self.prepararEstadoInicial()
    config.nivelActual(self)
    self.agregarVisuales()
    //self.configurarColisiones()
    self.configurarFrecuenciaPedidos()
    self.configurarNivel()
    self.configurarParrilla()
    self.configurarFuego()
    self.configurarAnimacion()
    self.programarEvento()
  }

  method objetosNivel() = [asador, parrilla, tablaDeCortar, listadoPedidos, cartel]

  method eventosPosibles() = [despejado]

  method programarEvento() {
    const momentoDeArranque = azar.numeroEntre(40, 95) * 1000
    eventoActual = self.eventosPosibles().anyOne()

    game.schedule(momentoDeArranque - 4000, {eventoActual.anunciarEvento()})
    game.schedule(momentoDeArranque, {eventoActual.empezarEvento()})
    game.schedule(eventoActual.momentoDeFin(momentoDeArranque), {eventoActual.terminarEvento()})
  }

  method reiniciarNivel() {
    game.clear()
    pantalla.configurarTeclado()
    menuPrincipal.iniciar()
  }

  method prepararEstadoInicial(){
    tiempoTranscurrido = 0
    aplausos = 0 
    self.objetosNivel().forEach({elemento => elemento.reiniciar()})
  }

  method terminarNivel(){
    cartel.mostrarCartel(aplausos, self.cantidadPuntosParaPasar())
    menuPrincipal.apagar()
    parrilla.apagar()
    self.ticksDelNivel().forEach({ tick => tick.stop() })
    listadoPedidos.pararPedidos()
    eventoActual.terminarEvento()
    pantalla.estadoActual(nivelTerminado)
  }

  method pedidosIniciales() = 2

  //el tiempo que pasa para que el fuego cambie de estado (fuerte -> medio -> bajo) 
  method tiempoCambioFuego() = 20000

  //  dispensers
  const unDispenser = new DispensadorAsado()
  const dosDispenser = new DispensadorChori()

  method duracionNivel()
  method tiempoRestante() = 0.max(self.duracionNivel() - self.tiempoTranscurrido())
  
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
    reloj.start()
  }

  //cada segundo suma tiempo y se verifica que termino el juego
  method avanzarReloj(){
    self.aumentarTiempo()
    if(self.terminoElJuego()){
      self.terminarNivel()
    }
  }
  //Como estaba antes saltaba terminar el juego siempre que el tiempo NO sea 0, ahora lo arregle
  method terminoElJuego() = self.tiempoRestante() == 0

  //configura la velocidad con la que los pedidos se agregan a la lista
  method configurarFrecuenciaPedidos(){
    self.pedidosIniciales().times({i => self.agregarPedidoAListaDePedidos()})
    agregarPedidosLista.start()
  }

  method agregarVisuales(){
    mesaCorte.agregarVisuales()
    tablaDeCortar.agregarVisuales()
    game.addVisual(unDispenser)
    game.addVisual(dosDispenser)
    parrilla.agregarVisuales()
    game.addVisual(barraDePedidos)
    mesaEntrega.agregarVisuales()
    game.addVisual(molinete)
    game.addVisual(asador)
    game.addVisual(listadoPedidos)
    game.addVisual(cronometro)
    game.addVisual(contadorAplausos)
    game.addVisual(iconoAplauso)
    //agregar aca todo lo que sea visual y que tenga que estar visible 
    //sea la parrilla, el asador, etc. 
  }
  
  //le dice a la parrilla que cocine la carne cada 1 segundo 
  method configurarParrilla(){
    cocinarCarne.start()
  }

  //cada x segundos le dice a la parrilla que se apague un poco, va al fuego anterior
  method configurarFuego() {
    bajarFuego.start()
  }

  method configurarAnimacion(){
    tiempoAnimaciones.start()
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
  const property desplazamientoX

  var property position = cartel.position().down(1).right(desplazamientoX)
  method image() = "fondoNegro.png" 
}

// Los 3 bloques que forman la tira ancha
object fondoIzquierda inherits SegmentoFondoTexto(desplazamientoX = 3) {}
object fondoCentro    inherits SegmentoFondoTexto(desplazamientoX = 4) {}
object fondoDerecha   inherits SegmentoFondoTexto(desplazamientoX = 5) {}

// El objeto que dibuja el texto
object cartelTexto inherits Chad {
  var property mensaje = ""

  
  method position() = fondoCentro.position()

  method text() = mensaje
  method textColor() = "FFFFFFFF"
}

object cartel inherits Chad {
  var property image = "cartel_victoria.png"
  const sonidoCartelVictoria = game.sound("sonido_victoria.mp3")
  const sonidoCarntelDerrota = game.sound("sonido_derrota.mp3")
  method position() = game.at(6, 5)
  override method esSolido() = false

  method mostrarCartel(puntos, cantidadPuntosParaPasar) {

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
    self.hacerSonido(sonidoCartelVictoria)
    cartelTexto.mensaje("VICTORIA! - " + puntos.toString() + "\n pts | [R] Reiniciar")
  }

  method mostrarCartelDerrota(puntos) {
    image = "cartel_derrota.png"
    self.hacerSonido(sonidoCarntelDerrota)
    cartelTexto.mensaje("DERROTA! - " + puntos.toString() + "\n pts | [R] Reiniciar")
  }

  method hacerSonido(sonido) { 
    sonido.play()
  }

  method reiniciar(){
    if(sonidoCarntelDerrota.played()){
      sonidoCarntelDerrota.stop()
    }
    if(sonidoCartelVictoria.played()){
      sonidoCartelVictoria.stop()
    }
  }
}