### SchemaValidation

https://www.mongodb.com/docs/v6.0/core/schema-validation/

Schema validation nos permite crear reglas de validación que van a controlar los datos que se van a insertar en 
las colecciones. Aunque mongo haga uso de un esquema flexible, esto no significa que entre documentos de la misma
colección, se puedan almacenar valores de distinto tipo en un mismo campo. 

### ¿Cuando hacemos uso de schema validation?

Si tu aplicación está en un punto de desarrollo temprano, no es recomendable hacer uso de los validadores ya que 
todavía se está modelando los datos y los schemas de datos pueden alterarse. Su uso es recomendado cuando el estado de la
aplicación sea maduro y tengamos la certeza de que nuestros esquemas no van a variar.

Algunos casos de uso:

- Campo de email debe de seguir un formato
- Campos numéricos que denben de almacenar digitos dentro de un rango específico
- Campos de tipo ENUM

Cuando creamos un esquema de validación despues de haber introducido datos , los nuevos inserts y los updates pasarán por 
dicha validación.

Es posible ejecutar una consula para buscar aquellos documentos que no cumplan con un esquema:

``` db.collection.find( { $nor: [ myschema ] } )  ```

### ¿Como creamos un esquema de validación?

Haremos uso del estandar jsonSchema (https://json-schema.org/learn/getting-started-step-by-step#create)

```
    
db.createCollection("MyCollectionName", {
   validator: {
      $jsonSchema: {
         bsonType: "object", # Obligatorio para MongoDb
         title: "MyCollectionName Object Validation", # Descripción de la validación
         required: [ "address", "major", "name", "year" ], # Campos requeridos
         properties: {  # Listado de campos los cuales se les va a aplicar una validatión
            name: {
               bsonType: "string", # Tipo de campo
               description: "'name' must be a string and is required" # Mensaje de error
            },
            hobbies: {
               bsonType: "array", # Tipo de campo
               description: "'hobbies' must be an array of strings", # Mensaje de error
               minItems:1,
               uniqueItems:True
               items:{
                    "bsonType":"string"
               }
            },
            year: {
               bsonType: "int",
               minimum: 2017,
               maximum: 3017,
               description: "'year' must be an integer in [ 2017, 3017 ] and is required"
            },
            gpa: {
               bsonType: [ "double" ],
               description: "'gpa' must be a double if the field exists"
            }
         }
      }
   }
} )
```

SI queremos consultar el esquema de validación actual de una colección, podemos hacer uso del siguiente comando:

``` db.getCollectionInfos({name:"collectionName"})[0].options.validator ```

Ojo! esto sabiendo que la colección tiene un validador asociado. 

Nota: Si hacemos uso del campo "additionalProperties", no permitimos que se añadan campos nuevos que no estén reflejados 
en nuestro esquema. Si la configuramos a true, debemos de añadir el campo "_id" dentro de nuestro required.

### Modificar un esquema de validación / añadir validación a una colección existente

Si en cualquier momento queremos modificar un esquema de validación o añadir una validación a una colección existente,
podemos hacer uso del comando "collMod":

```

db.runCommand( { collMod: "MyCollection",
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: [ "username", "password" ],
         properties: {
            username: {
               bsonType: "string",
               description: "must be a string and is required"
            },
            password: {
               bsonType: "string",
               minLength: 12,
               description: "must be a string of at least 12 characters, and is required"
            }
         }
      }
   }
} )



```

