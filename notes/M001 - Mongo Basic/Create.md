### Create 

https://www.mongodb.com/docs/v6.0/reference/insert-methods/

- InsertOne (Mongo): 

  `` db.collection.insertOne({"name":"Miguel","surname":"Rojo"}) ``

    Inserta un documento en nuestra colección. Por defecto devolverá el _id insertado en el siguiente formato:
    
    `` {acknowledged: true, insertedId: ObjectId('65b390b94c9e2411e1878753')} ``


- InsertMany (Mongo):

  `` db.collection.insertMany([{"name":"Miguel","surname":"Rojo"},{"name":"Pablo","surname":"Rojo"}],{"ordered":false}) ``

    Permite insertar múltiples documentos en nuestra colección devolviendo los _id insertados en el siguiente formato:

    ``` {
      acknowledged: true,
      insertedIds: {
        '0': ObjectId('65b393174c9e2411e1878755'),
        '1': ObjectId('65b393174c9e2411e1878756')
      }
    } 
  ```
    Opcionalmente, podemos pasarle la opción de documento booleana "ordered" para que cambie el comportamiento al insertar. Si dicha
    variable es false insertará TODOS los registros , excepto los que den error. En el caso de que sea true (por defecto)
    los irá insertando de forma secuencial hasta que uno de ellos de error.

    Nota del libro : No puede superar más de 48Mb