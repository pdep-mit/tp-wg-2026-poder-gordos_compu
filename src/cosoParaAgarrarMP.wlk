import wollok.game.*
import carnes.*
import superClaseChad.*
//le hay que cambiar el nombre pero basicamente es el lugar de donde podes agarrar las carnes, verduras panes etc

class Dispensador inherits Chad{
    override method esSolido() = true
    
    method loQueDoy()
    //la logica deberia estar aca

    method position() 

    method image() 

    method dispensar(){
        //deberia crear una nuva clase de lo que doy y darle la posicion que tiene el dispensador
    }
}

class DispensadorAsado inherits Dispensador{
    //dispensar asado
    override method loQueDoy() = new Asado(posicionEnSuelo = game.at(2,3))
    //hacer metodo boludo para cambiar lo que doy
}

class DispensadorChori inherits Dispensador{
    //dispensar chori
}

//etc...