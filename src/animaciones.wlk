
object animaciones {
    var contador = 0 
    
    method siguienteFrame(cantidadFrames) = contador % cantidadFrames 

    method aumentarContador() {
        contador += 1        
    }
}