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

(...terminar)

# Diagramas

*Incluír al menos un diagrama para comunicar su solución*