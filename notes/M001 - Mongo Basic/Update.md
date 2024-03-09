### Update

Operadores más usados:

- $set: Establece el valor del campo por el valor especificado. Si el campo no existe en el documento, lo crea
  https://www.mongodb.com/docs/manual/reference/operator/update/set/
  
  ```
    db.scores.updateOne( { name: "Jhon" }, { $set: { email: jhon@gmail.com } } )
  ```

- $unset: Elimina un campo
  https://www.mongodb.com/docs/manual/reference/operator/update/unset/
  
  ```
    db.scores.updateOne( { name: "Jhon" }, { $unset: { tmp_email:"" } } )
  ```

- $setOnInsert: Igual que el $set,pero únicamente se almacena el valor en el insert. Es usado normalmente para inicializar
  valores de una colección o para campos de tipo timestamp.
  https://www.mongodb.com/docs/manual/reference/operator/update/setOnInsert/


- $currentDate: Establece la fecha actual al campo.
  https://www.mongodb.com/docs/manual/reference/operator/update/currentDate/


- $inc: Incrementa en X el valor del campo:
  https://www.mongodb.com/docs/manual/reference/operator/update/inc/
  
    ```
      db.products.updateOne({ sku: "abc123" },
        { $inc: { quantity: -2, "metrics.orders": 1 } }
     )
    ```    

- $min / $max: Actualiza el campo solo si el valor especificado es menor/mayor al existente.
  https://www.mongodb.com/docs/manual/reference/operator/update/max/

  Si el valor de highScore > 950 , se actualizará a 985

  ```
    db.scores.updateOne( { _id: 1 }, { $max: { highScore: 950 } } )
  ```
- $mul: Multiplica el valor del campo por la cantidad especificada
  https://www.mongodb.com/docs/manual/reference/operator/update/mul/  

  ```
    db.scores.updateOne( { _id: 1 }, { $mul: { highScore: 2 } } )
  ```