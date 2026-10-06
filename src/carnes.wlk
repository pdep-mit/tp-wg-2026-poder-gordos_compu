import wollok.game.*
import asador.*
import barrasAviso.*


/* class Carne {
  var property timpo 

  la carne deberia ser una clase que tenga lo de siempre, y cuando veamos herencia podemos hacer cosas mas especificas pero x ahora 
  podemos hacer una clase x tipo de carne  
} */

//todas las carnes deben de entender el mensaje cocinar()

// creamos objeto sin portador para que todos puedan calcular sus posiciones
object sinPortador{
  
}

class Asado {
  const property nombre = "asado"
  //el tiempo que pasa en la parrilla en puntos de coccion 
  var tiempoParrilla = 0 
  const tiempoCoccion = 16 // en puntos de coccion
  var imagenActual = "asado_crudo.png"

  //creamos la barra de progreso de la carne /
  const barraProgreso = new BarraProgreso() 

  //cocido luego podria pasar a ser un estadoCarne que tenga la referencia a un objeto que sean los diferentes estados (crudo, jugoso, cocido, etc), vinculado a la barra de progreso
  var cocido = false
  //la posicion de la carne va a depender de la posicion del asador
  var property position = game.at(2,2)

  //deberia preguntarle al asador para donde esta mirando y luego devolver la posicion uno mas arriba, abajo, a la izquierda o derecha
  //pero primero deberia de tener una posicion inicial de donde saca la carne, le deberia pregunar rambien al coso que suministra la carne a ver donde esta
  //lo ultimo en caso de que no lo hayan agarrado 
  method calcularPosicion(){
    
  }

  //esto de las imagenes seguro que se puede mejorar -- preguntar en clase jeje


  //seria el tiempo (o puntos de coccion) que le damos de chance para que evite que se queme 
  method tiempoDeOnda() = 4

  method image() = imagenActual

  method imagenCocida() {    
   if(cocido){
    imagenActual = "imagen de la carne cocida"
    }
  }

  method imagenQuemada() {
    imagenActual = "imagen de la carne quemada"
  }

  //da 4 puntos de coccion de chance para que la vayas a sacar (si el fuego esta fuerte seria un solo segundo - tal vez hay que dar un poco mas)
  method seQuemo() = tiempoParrilla > tiempoCoccion + self.tiempoDeOnda()

  method cocinar(calor) {
    tiempoParrilla += calor

    if(tiempoParrilla >= tiempoCoccion) {
      cocido = true
      self.imagenCocida()
      //deberia de avisar que se cocino y dar una alerta para que no c queme 
      //podemos generar una nueva instancia de alerta, en la posicion que tenga la carne en ese momento 
    }
    if(self.seQuemo()){
      self.imagenQuemada()
      //podriamos a hacer que muestre una barra de que se quemo
      //luego podriamos poner la imagen de la parrilla que sea quemada o que se prenda fuego 
    }
  }

  //regla de tres simple para el porcentaje de la carne a ver como se encuentra
  //tiempoCoccion -> 100%
  //tiempoParrilla -> x 
  method comoAndas() = (tiempoParrilla * 100) / tiempoCoccion

  method enLaParrilla(){
    barraProgreso.carneActual(self)
    game.addVisual(barraProgreso)
  }

  method fueraDeParrilla() {
    game.removeVisual(barraProgreso)
  }

}

class Vacio {
  const property nombre = "vacio"
}

class Lomo {
  const property nombre = "lomo"
}

class Chorizo{
    var property posicionInicial = game.at(5,5) 
    var property portador = sinPortador 
    const property nombre = "chori" 
    const imagenActual = "Chori_Cocido_0.png"

    method image() = imagenActual
    
    method position() =
      if (portador == sinPortador){
        posicionInicial
      }
      else{
        portador.position().left(1).up(1)
      
    }
    method llevadoPor(alguien){
      portador = alguien
    }
    method soltar() {
      posicionInicial = self.position()
      portador = sinPortador
    }
    
    method cortar() {
      
    }
}

class Morcilla {
  const property nombre = "morcilla"
}

//esto es lo que explico la profe que esta re piola para poner el objeto vacio 
object noCarne {
  method cocinar(calor){}
  method comoAndas() = 0
  method seQuemo() = false
  method enLaParrilla(){}
  method fueraDeParrilla(){}
}