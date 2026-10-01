import wollok.game.*

/* class Carne {
  var property timpo 

  la carne deberia ser una clase que tenga lo de siempre, y cuando veamos herencia podemos hacer cosas mas especificas pero x ahora 
  podemos hacer una clase x tipo de carne  
} */

//todas las carnes deben de entender el mensaje cocinar()

class Asado {
  //el tiempo que pasa en la parrilla en puntos de coccion 
  var  tiempoParrilla = 0 
  const  tiempoCoccion = 16 // en puntos de coccion
  var imagenActual = "imagen de la carne cruda"
  //esto x ahora no tiene mucho sentido pero si hacemos que la carne tenga puntos de coccion va a importar
  var cocido = false 

  //esto de las imagenes seguro que se puede mejorar -- preguntar en clase jeje

  method image() = imagenActual

  method imagenCocida() {
    if(cocido) {
      imagenActual = "imagen de la carne cocida"
    }
  }

  method imagenQuemada() {
    imagenActual = "imagen de la carne quemada"
  }

  //da 4 puntos de coccion de chance para que la vayas a sacar (si el fuego esta fuerte seria un solo segundo - tal vez hay que dar un poco mas)
  method seQuemo() = tiempoParrilla > tiempoCoccion + 4

  method cocinar(calor) {
    tiempoParrilla += calor

    if(tiempoParrilla >= tiempoCoccion) {
      cocido = true
      self.imagenCocida()
    }
    if(self.seQuemo()){
      self.imagenQuemada()
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

//esto es lo que explico la profe que esta re piola para poner el objeto vacio 
object noCarne {
  method cocinar(calor){}
}