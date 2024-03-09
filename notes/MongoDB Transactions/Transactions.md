## Mongo Transactions

Mongo dispone de un mecanismo para ejecutar queries siguiendo ACID:

 - Atomicity (Atomicidad) : O se ejecutan todas las consultas o no se ejecuta ninguna.

 - Consistency (Consistencia): Mantiene la consistencia en la base de datos.

 - Isolation (Aislamiento): Una operación no puede afectar a otras.

 - Durability (Durabilidad): Una vez realizada la operación , esta se quedará en el sistema.


Usaremos las transacciones cuando necesitemos ejecutar una serie de consultas que deben de mantener su integridad , todas
juntas y no por separado.

Comandos : 

 - .startSession(): Nos devuelve un objeto session para poder ejecutar nuestra transacción.

 - session.startTransaction(): Nos permite comenzar la transacción. Las consultas consecutivaa serán las que conformen la 
   transacción.

 - session.commitTransaction(): Nos permite confirmar el cierre del bloque la transacción y ejecutar las consultas que hayamos realizado anteriormente.
   dando lugar a la siguiente salida :

  ```
  {
  ok: 1,
  '$clusterTime': {
    clusterTime: Timestamp({ t: 1647437775, i: 5 }),
    signature: {
      hash: Binary(Buffer.from("b0d88d5a96372efb9af22021cdd59021741ddb5c", "hex"), 0),
      keyId: Long("7019511514256113665")
    }
  },
  operationTime: Timestamp({ t: 1647437775, i: 5 })
}
  ```
    
 - session.abortTransaction() Nos permite cancelar una transacción y las consultas no se ejecutarán en la BBBDD por lo que no tendrán persistencia.
