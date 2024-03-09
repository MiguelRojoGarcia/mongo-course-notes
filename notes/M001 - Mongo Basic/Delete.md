### Delete 

https://www.mongodb.com/docs/v6.0/reference/delete-methods/

- DeleteOne (Mongo): 

  `` db.collection.deleteOne(<filter>) ``

    Elimina un documento que haga match con el filtro, si existen varios documentos , unicamente elimina el primero
    
    `` { "acknowledged" : true, "deletedCount" : 1 } ``

https://www.mongodb.com/docs/manual/reference/method/db.collection.deleteMany/

- DeleteMany (Mongo):

  `` db.orders.deleteMany(<filter>); ``

    Elimina todos los documentos que hagan match con el filtro

    ``{ "acknowledged" : true, "deletedCount" : 10 }``