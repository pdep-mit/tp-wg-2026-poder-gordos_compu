import src.asador.*
import wollok.game.*
import carnes.*
import superClaseChad.*
//le hay que cambiar el nombre pero basicamente es el lugar de donde podes agarrar las carnes, verduras panes etc


class Dispensador inherits Chad{
    
    method position()
    method generar()
    method mostrarme(elemento)
    {
        game.addVisual(elemento)
    }
    //la logica deberia estar aca
    override method esSolido() = true
    override method dejarAgarrarPor(parrillero){
        const algo = self.generar()
        self.mostrarme(algo)
        algo.dejarAgarrarPor(parrillero)     
    }

    

}

class DispensadorAsado inherits Dispensador{
    override method generar() = new TiraAsado(posicionEnSuelo = self.position())
    method image() = "dispenser_carne.png"
    override method position()= game.at(11, 7)
}
class DispensadorChori inherits Dispensador{
    override method generar() = new Chorizo(posicionEnSuelo = self.position())
    method image() = "dispenser_chori.png"
    override method position()= game.at(14, 7)
}