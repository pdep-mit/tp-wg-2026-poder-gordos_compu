
object animaciones {
    //esto funciona para animaciones de 8 frames -> si queremos menos o mas frames podemos tener mas objetos
    const contidadFrames = 8
    var property contador = 0 
    
    method aumentarContador() {
        contador = (contador + 1) % contidadFrames 
    }
}