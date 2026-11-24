import src.barrasAviso.*
import wollok.game.*
import carnes.*
import animaciones.*
import superClaseChad.*
import elementosInvisibles.*

object parrilla inherits Chad {
  const property position = game.at(4,3)
  const property barraEsfuerzo = new BarraEsfuerzo(duenio = self)
  override method esSolido() = true
  const sonidoPlacer = game.sound("cocinando_carne.mp3") 
  var property fuego = apagado
  var property carneActual = noCarne 

  method reiniciar() {
    carneActual = noCarne
    fuego = apagado
    self.apagar()
    self.reiniciarEsfuerzo()
    }

  method agregarVisuales(){
    game.addVisual(self)
    game.addVisual(new ElementoAuxiliar(duenio = self, desplazamientoX = 1,desplazamientoY = 0))
    game.addVisual(barraEsfuerzo)
  }

  method image() = fuego.imagenParrilla()

  method asar() = carneActual.cocinar(fuego.calor())

  method soltar(carne) {
    carneActual = carne
    carne.enLaParrilla()
    carne.asignarA(self)
  } 

  method sacarCarne(){
    carneActual.fueraDeParrilla()
    carneActual = noCarne
  }

  method posicionPara(item) = position

  //le preguntamos a la parrilla si esta libre para que le pongan una carne
  method estaOcupada() = carneActual.esCarne()

  override method recibir(carga){
    /*
    * hacemos una verificacion y luego la logica del metodo ;) 
    */
    if(self.estaOcupada()){
      self.error("la parrilla esta ocupada")
    }
    carga.ponerseEn(self)
    fuego.aplicar(sonidoPlacer)
  }

  method remover(carne){
    self.sacarCarne()
    self.apagar()
  }

  method avivar() { 
    fuego.avivarCon(barraEsfuerzo)
  }

  method terminoElEsfuerzo(){
    fuego = fuego.siguiente()
    //cuando avivas el fuego y tiene una carne puesta deberia arrancar el sonido
  }

  method apagarPoco() {
    fuego = fuego.anterior()
  }

  override method dejarAgarrarPor(parrilero){
    carneActual.dejarAgarrarPor(parrilero)
  }
  
  method posicionBarra() = self.position().up(1)
  
  method reiniciarEsfuerzo() {
    barraEsfuerzo.reiniciar()
  }

  method apagar(){
    if(sonidoPlacer.played()){
      sonidoPlacer.stop()
    }
  }

  method muestraItemFrame() = false

  override method usar(){
    self.avivar()
  }
}


class Fuego{
  method avivarCon(barra){
    barra.esforzar() 
  }

  method aplicar(sonido){
    sonido.play()
    sonido.shouldLoop(true)
  } 

  method imagenParrilla() = "parrilla_"+ self.intensidad() +"_"+ animaciones.siguienteFrame(8)+".png"

  method intensidad() 
}

//el calor son puntos de coccion 
object apagado inherits Fuego {
  method calor() = 0

  override method imagenParrilla() = "parrilla_apagada.png"

  method anterior() = self

  method siguiente() = bajo 

  override method aplicar(sonido){} 

  override method intensidad() = "apagado"
}

object bajo inherits Fuego {
  method calor() = 1

  override method intensidad() = "bajo"

  method anterior() = apagado
  
  method siguiente() = medio

}

object medio inherits Fuego {
  method calor() = 2 

  override method intensidad() = "medio"

  method anterior() = bajo
  
  method siguiente() = fuerte

}

object fuerte inherits Fuego {
  method calor() = 3

  override method intensidad() = "alto"

  method anterior() = medio
  
  method siguiente() = self

  override method avivarCon(barra){}

}

//agregamos un tipo de fuego que sea mojado 
object mojado {
  //tal vez podriamos hacer que la parrilla mojada le reste tiempo de parrila a la carne 
  method calor() = 0

  method imagenParrilla() = "parrilla_mojada.png"

  method anterior() = self
  
  method siguiente() = apagado

  method avivarCon(barra){}

  method aplicar(sonido){
    sonido.play()
    sonido.shouldLoop(true)
  } 
}