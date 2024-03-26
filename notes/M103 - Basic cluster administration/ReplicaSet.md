### Mongo Replicas

Las replicas son usadas para mantener la redundancia y alta disponibilidad de datos. Mongo ofrece algunas 
características especiales bajo servidores con replicas, como por ejemplo los change-streams (https://www.mongodb.com/developer/languages/javascript/nodejs-change-streams-triggers/) 
o las transacciones.

En PROD nunca deberíamos de usar un entorno no replicado.

Un servidor en replica set está formado por nodos y cada nodo es una copia exacta del otro (Ejemplo imagen triangular).
El numero de nodos debe de ser impar. (regla mitad + 1)

Para mantener los datos sincronizados entre nodos, mongo hace uso de una colección especial llamada oplog (https://www.mongodb.com/docs/manual/core/replica-set-oplog/)
la cual almacena  las operaciones de escritura. El resto de nodos , recogen dicha información y se actualizan. Este mecanismo es el que permite
la redundancia de datos entre nodos.


Si estamos dentro de un entorno con replica set, podemos derivar las operaciones de lectura a un nodo con un hardware pensado para mejorar
el rendimiento en las operaciones de lectura. Mientras que las operaciones de escritura se pueden delegar a otros nodos.

### Diferencia entre un RS y un cluster.

La RS consisite en la duplicación de datos en diferentes nodos/servidores. Mientras que un cluster distribuye la carga de trabajo y los datos
en diferentes servidores. Esto se denomina como Shards.


### ¿Como configuramos un RS?

Revisar documentación.

Una vez configurado el RS, podemos lanzar el comando rs.status() para verificar el estado de la RS.

Notas adicionales:

- Si queremos que uno de nuestros nodos secundarios realice operaciones de lectura, debemos de indicárselo con el siguiente comando:
    
    ``` db.getMongo().setReadPref("secondary") ```
    
    Esto nos permitirá habilitar el nodo secundario como nodo de lectura.


