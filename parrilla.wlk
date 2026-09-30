import wollok.game.*

//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla {
//el fuego puede tener tres estados, 0 apagado, 1, poca llama, 2 media y 3 fuerte (se hace mas rapido pero se puede quemar)
//el fuego deberia ser una variable que pertenezca a la interfaz de la parrilla ya que el asador debe de ser capaz de modificarlo 
var property fuego = 0 

    method cocinar(carne) {
        //tengo que preguntarle a la carne su tiempo de coccion 
        //hay que revisar el fuego de la parrilla
        //tengo que decirle a la carne que ponga su imagen de cocida
        
        if(fuego == 0){
            return carne.image()
        }
        if(fuego == 1){
            //deberia esperar un toque
            return carne.imagenCocida()
        }
        if(fuego == 2){
            //deberia esperar un toque menos 
            return carne.imagenCocida()
        }
         if(fuego == 3){
            //deberia esperar un toque menos menos  
            return carne.imagenCocida()
        }

        return carne.image()

        //estoy seguro de que se puede hacer 1000 vecez mejor
  }

//... mas cosas
}