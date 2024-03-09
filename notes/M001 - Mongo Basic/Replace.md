### Replace

https://www.mongodb.com/docs/manual/reference/method/db.collection.replaceOne/

- ReplaceOne:
  
  
    ``` db.collection.replaceOne(<filter>, <replacement>, <options>) ```  

    
  Funciona de forma silimar al update salvo que reemplaza todo el documento. Podemos encontrar las siguientes opciones:
  
   - upsert (boolean): Si no encuentra un documento, lo crea.
   - hint: (document): Fuerza el uso de un índice.