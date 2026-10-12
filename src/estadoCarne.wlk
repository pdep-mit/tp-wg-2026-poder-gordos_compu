
object crudo {
    method estado() = "crudo"

    method siguienteEstado(carne) {
        if(carne.estaCocida()) {
           return cocido
        } 
       return self
    }
}

object cocido {
    method estado() = "cocido"

    method siguienteEstado(carne) {
        if(carne.seQuemo()) {
           return quemado
        } 
       return self
    }
}

object quemado {
    method estado() = "quemado"

    method siguienteEstado(carne) = self
}