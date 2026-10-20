import superClaseChad.*

/*
* aca va la clase de elementos invisibles o auxiliares generica 
*/

class ElementoAuxiliar inherits Chad{
    const duenio
    const  desplazamientoX 

    method position() = duenio.position().right(desplazamientoX)
    method image() = "imagenInvisible.png" 
    override method esSolido() = duenio.esSolido()
    override method recibir(carga){ duenio.recibir(carga)}
    override method avivar(){duenio.avivar()}
    override method dejarAgarrarPor(parrillero){ duenio.dejarAgarrarPor(parrillero)}
}