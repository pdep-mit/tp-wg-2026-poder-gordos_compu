import src.barrasAviso.*
import wollok.game.*
import carnes.*
import animaciones.*
import superClaseChad.*
import elementosInvisibles.*

//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla inherits Chad {
  const property position = game.at(4,3)
  const barraEsfuerzo = new BarraEsfuerzo(duenio = self)
  override method esSolido() = true 

  method agregarVisuales(){
    game.addVisual(self)
    game.addVisual(new ElementoAuxiliar(duenio = self, desplazamientoX = 1,desplazamientoY = 0))
    game.addVisual(barraEsfuerzo)
  }

  //func: la parrilla solo puede tener una unica carne a la vez
  //el fuego puede tener tres estados, 0 apagado, 1, poca llama, 2 media y 3 fuerte (se hace mas rapido pero se puede quemar)
  //el fuego es un objeto que tiene un calor especifico 
  var property fuego = fuerte
  var property carneActual = noCarne 

  method image() = fuego.imagenParrilla()

  //absolute cinema -- la parrilla "asa" cada 1 segundo pero dependiendo del fuego se cocinara mas lento o mas rapido 
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

  // Polimorfismo con los contenedores para ubicar el item
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
  }

  method remover(carne){
    self.sacarCarne()
  }

  override method avivar() { 
    barraEsfuerzo.esforzar() 
  }

  method terminoElEsfuerzo(){
    fuego = fuego.siguiente()
  }

  method apagarPoco() {
    fuego = fuego.anterior()
  }

  override method dejarAgarrarPor(parrilero){
    carneActual.dejarAgarrarPor(parrilero)
  }
  
  method posicionBarra() = self.position().up(1)
  //... mas cosas
}


//el calor son puntos de coccion 
object apagado {
  method calor() = 0

  method imagenParrilla() = "parrilla_apagada.png"

  method anterior() = self

  method siguiente() = bajo 
}

object bajo {
  method calor() = 1

  method imagenParrilla() = "parrilla_bajo_" + animaciones.siguienteFrame(8) + ".png"

  method anterior() = apagado
  
  method siguiente() = medio
}

object medio {
  method calor() = 2 

  method imagenParrilla() = "parrilla_medio_" + animaciones.siguienteFrame(8) + ".png"

  method anterior() = bajo
  
  method siguiente() = fuerte
}

object fuerte {
  method calor() = 3

  method imagenParrilla() = "parrilla_alto_" + animaciones.siguienteFrame(8) + ".png" 

  method anterior() = medio
  
  method siguiente() = self
}

//agregamos un tipo de fuego que sea mojado 
object mojado {
  //tal vez podriamos hacer que la parrilla mojada le reste tiempo de parrila a la carne 
  method calor() = 0

  method imagenParrilla() = "parrilla_mojada.png"

  method anterior() = self
  
  method siguiente() = apagado
}