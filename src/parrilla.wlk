import wollok.game.*
import carnes.*

//la parrila tmb puede ser una clase ya que podemos tener mas de una parrilla 
object parrilla {
//func: la parrilla solo puede tener una unica carne a la vez
//el fuego puede tener tres estados, 0 apagado, 1, poca llama, 2 media y 3 fuerte (se hace mas rapido pero se puede quemar)
//el fuego deberia ser una variable que pertenezca a la interfaz de la parrilla ya que el asador debe de ser capaz de modificarlo 
var property fuego = 0 


    method cocinar(carne) {
        const tiempoCoccion = carne.tiempoCoccion()
        const tiempoParrilla = 0
        //tengo que preguntarle a la carne su tiempo de coccion 
        //hay que revisar el fuego de la parrilla
        //tengo que decirle a la carne que ponga su imagen de cocida
        
        //maybe esto se deberia preguntar cada x tiempo en caso de que el fuego se modifique (lo puse cada 1 segundo)
        //deberia de existir una forma de iniciar una especie de contador o sumarle uno a tiempoParrilla para controlar el tiempo
        if(!carne.cocido())
            game.onTick(1000, "cocinarCarne", {
                if(fuego == 1){
                    //deberia esperar un toque
                carne.cocido(true)
                carne.imagenCocida()
            }
            if(fuego == 2){
            //deberia esperar un toque menos
                carne.cocido(true)
                carne.imagenCocida()
            }
             if(fuego == 3){
            //deberia esperar un toque menos menos  
                carne.cocido(true)
                carne.imagenCocida()
            }
            if(self.seQuemo(carne, tiempoParrilla)){
                carne.cocido(true)
                carne.imagenQuemada()
                //deberia cortar el loop para que no se evalue mas la condicion de del fuego 
            }
        })
    }
    
    // si la carne estuvo mas tiempo que su tiempo de coccion entonces se quemo
    method seQuemo(carne, tiempoParrilla) = tiempoParrilla > carne.tiempoCoccion()

//... mas cosas
}