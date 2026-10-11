
object animaciones {
    var property contador = 0 
    
    method aumentarContador(contidadFrames) {
        contador = (contador + 1) % contidadFrames 
    }
}