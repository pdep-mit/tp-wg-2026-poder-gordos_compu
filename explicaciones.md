# Explicaciones teóricas

*Completar comentando dónde se aplicaron los distintos conceptos buscados*

# Polimorfismo

en el TP nos aseguramos de ser lo mas polimorfos posible. La instancia donde mas se ve el polirfismo en con
nuestra SuperClase *Chad*, ya que contiene los metodos necesarios para que todos los items visibles en la pantalla
entiendan los mensajes ...(redactar)

Luego en la parrilla se puede observar el polimorfimo con el *Fuego* ya que todos los tipos diferentes de fuego, sean fuerte, medio, bajo y apagado, entienden mensajes comunes que le permiten a la parrilla comunicarse sin estar preguntando todo el tiempo cual es su potencia ...(readctar)

Luego tenemos el metodo *recibir(carga)*, el cual comparten todos los elemtos capaces de interactuar con la carne y el asador, es decir que el asador interactua con un objeto que altera el esatado de otro, ya sea, cortandolo, cocinandolo, o entregandolo  

(agregar mas a piacere)

# Herencia

La herencia esta mas precesente en este TP que hanz en la clase de pdep, el mas evidente es la clse *Chad* como explicamos anteriormente 

Luego esta fuertemente presente con la clase *Carne* ya que todas las "carnes", asado, chorizo, lomo, vacio hereden de la misma el mismo comportamiento cambiando unicamente su nombre, su tiempo de coccion y el pedido al cual esta asociado (para luego verificar con la entrega del mismo) 

Ademas tenemos la superClase *ElementoAgarrable* la cual la heredan todos los elementos que son agarragbles, en este caso lo hereda la clase *Carne* y *TiraDeAsado* que seria un asado antes de ser cortado 

# Delegacion 

Durante el desarrollo del TP nos aseguramos fuertemente de que haya un nivel de delegacion optimo 

En carne, podemos ver que tanto su imagen como saber cuando cambia de estado, se lo delega al atributo *estado* los cuales son tres objetos que contienen los tres posibles estados de la carne, crudo, cocido y quemado (por el momento). Ademas su posicion se la delega a la posicion del asador 

En ElementoAuxiliar, podemos ver que tanto su colisión como cualquier interacción que reciba, se las delega al atributo duenio, el cual referencia al objeto original (como la mesa de corte o la parrilla). Esto permite extender la superficie del mueble a lo largo del mapa sin duplicar su lógica ni su estado.

# Encapsulamiento 

Durante el desarrollo nos aseguramos de ocultar el estado interno de los objetos, evitando que se modifiquen libremente desde afuera y exponiendo solo los métodos necesarios para que el resto del sistema interactúe.

Un caso se da en la superclase *Carne*. Los atributos `tiempoParrilla` y `estado` son variables internas que no exponen su modificación directa mediante properties. Ni la parrilla ni el asador necesitan saber exactamente cuántos puntos de cocción tiene la porción en crudo ni le cambian el estado "a mano". La parrilla simplemente le envía el mensaje `cocinar(calor)` a la carne. Es la propia carne la que encapsula la regla de aumentar su cocción y decidir por sí misma si debe invocar a `estado.siguienteEstado(self)`.

Otro ejemplo de encapsulamiento se ve en la superclase *ElementoAgarrable* con la gestión de su `contenedor`. Para que un item cambie de manos (del piso al asador, o del asador a la tabla), no se le pisa la variable `contenedor` desde afuera, sino que se utiliza el método `asignarA(nuevoContenedor)`, que se encarga de mostrar u ocultar el frame en la interfaz, se desvincula de su contenedor anterior avisándole con `contenedor.remover(self)` y finalmente se guarda la referencia del nuevo dueño.

También, en la clase *Nivel*, aplicamos encapsulamiento sobre las mecánicas de la partida. El atributo `tiempoRestante` no tiene property, por lo que nadie puede adelantarlo; está encapsulado y solo se incrementa mediante el método `aumentarTiempo()` que llama el motor en cada tick. Lo mismo ocurre con los `aplausos` (el puntaje): en lugar de que otros objetos sumen o resten directamente sobre la variable, se ven obligados a interactuar usando los mensajes `sumarPuntos(puntos)` y `restarPuntos(puntos)`.

# Diagramas

esto esta en diagamaDeClases.puml, no seas malo rasta abrilo desde ahi es *option d* `;)`

*Incluír al menos un diagrama para comunicar su solución*