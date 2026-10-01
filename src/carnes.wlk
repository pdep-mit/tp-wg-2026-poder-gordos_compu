import wollok.game.*

/* class Carne {
  var property timpo 

  la carne deberia ser una clase que tenga lo de siempre, y cuando veamos herencia podemos hacer cosas mas especificas pero x ahora 
  podemos hacer una clase x tipo de carne  
} */

class Asado {
  //el tiempo que pasa en la parrilla
  var property tiempoParrilla = 0 
  var property tiempoCoccion = 5000 //en milisegundos, 5s 
  var property imagenActual = "imagen de la carne cruda"
  var property cocido = false 

  method image() = imagenActual

  method imagenCocida() {
    if(cocido) {
      imagenActual = "imagen de la carne cocida"
    }
  }



}

class Vacio {
  
}

class Lomo {
  
}

class Chorizo{

}

class Morcilla {
  
}