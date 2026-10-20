import wollok.game.*
import carnes.*
import superClaseChad.*
//le hay que cambiar el nombre pero basicamente es el lugar de donde podes agarrar las carnes, verduras panes etc


class Dispensador inherits Chad{
    
    method position()
    method loQueDoy()
    //la logica deberia estar aca

    method dispensar(){
        //deberia crear una nuva clase de lo que doy y darle la posicion que tiene el dispensador
    }

    

}

class DispensadorAsado inherits Dispensador{
    //dispensar asado
    override method loQueDoy() = new Asado(posicionEnSuelo = self.position())
    //hacer metodo boludo para cambiar lo que doy
    // esto esta mal pero por ahora lo dejo 
    method image() = "dispenser_carne.png"
    override method position()= game.at(11, 7)
    

}

class DispensadorChori inherits Dispensador{
    //dispensar chori
}

//etc...