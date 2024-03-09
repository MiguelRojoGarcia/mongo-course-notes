### Aggregations

Nos permiten procesar y devolver la información sin que afecte a los datos almacenados.

 - Aggregation: Collection and summary of data
 - Stage: One of the built-in methods that can be completed on the data, but does not permanently alter it
 - Aggregation pipeline: A series of stages completed on the data in order

El procesamiento se realiza a través de una "pipelanes" o etapas. Cada etapa realiza operaciones con los datos de entrada,
dejando el resultado (los datos de salida), para la siguiente etapa o ninguna etapa.

Para ello usaremos el método ``` aggregate() ``` que recibe un array de operaciones (pipelines).


Debemos de tener precaución al construir nuestro pipeline ya que el orden en le cual contruimos nuestros stages influye en el 
rendimiento, cada stage va a devolver un número de documentos. Por ejemplo, es recomendable poner siempre al principio
el stage $match ya que esto nos asegura que los siguientes stages reciban menos documentos a procesar. 

Otro ejemplo es que si queremos limitar el resultado de una pipeline y el order importa, colocaremos primero el $sort antes que 
el $limit. 

Si en nuestra pipeline tenemos un $limit, lo colocaremos antes del $project. Esto mejorará el rendimiento de la query ya 
que el nº de documentos que reciba el $project, será mejor por haber pasado antes por un $limit.

Estos són los operadores más utilizados en las etapas : 

### $match

Filtrado de documentos por un criterio.

Nota : Usaremos la "dot notation" para acceder a atributos de objetos o valores de un array : {"$match":"customer.addres.city":"Málaga"} 

### $project

Permite descartar campos o contruir campos calculados a partir de campos existentes o de acumuladores (solo en el caso de los arrays)

Si necesitamos construir un campo a partir de un campo existente, haremos referencia al campo existente con $.

Ejemplos:
```
{"$project":{"full_name":{$concat:{"$name"," ","$surname"}}

{"$project":{"_id": 0,"gender": 1,"city": "$address.city",}}

{"$project":
         {
             "_id": 0,
             "gender": 1,
             "city": "$address.city",
             "other_city": {"$first":"$other_addresses.city"},
         }
    }


```

### $group
https://www.mongodb.com/docs/manual/reference/operator/aggregation/group/

Permite agrupar el resultado dado un campo. La posible salida es un documento por cada valor diferente del campo proporcionado.

``` {
 $group:
   {
     _id: <expression>, // Group key
     <field1>: { <accumulator1> : <expression1> },
     ...
   }
 }
   ````

El operador <accumulator1> es un comando que nos permite acumular, estos son algunos acumuladores:

- $avg: Sacar la media
- $sum: Sumatoria
- $count: Cuenta los registros
- $first/$last: Devuelve el primer/último elemento definido en <expression1> ,  normalmente es el nombre de un campo. 
- $push: Devuelve un array que contiene los datos de la expresión por cada documento del group 

Dentro de la exprexión, podemos hacer usor de otros operadores como por ejemplo, $round, $concat...

Nota: Para el $group, el campo $_id es el cual vamos a realizar la agrupación.

Algunos ejemplos del group:
https://www.mongodb.com/docs/manual/reference/operator/aggregation/group/#std-label-ex-agg-group-stage


### $set

Añade campos calculados o manipula campos existentes. Podemos aplicar operadores a campos calculados en etapas anteriores.
Por ejemplo , aplicar un operador a un campo creado en una etapa anterior de tipo $group. Además podemos añadir campos 
calculados a objetos existentes

```   
  { $set: { <newField>: <expression>, ... } }
  
  Ejemplos:
  { $set: { "total_reviews": {$sum:"$reviews"} } }
  { $set: { "object.calculated_field": "value" } }
  
```

### $unset

Elimina un campo de la proyección

### $sort

Ordena los documentos

### $limit

Limita el nº de documentos a devolver.

### $count

Devuelve un único campo con el total de registros encontrados.

### $out

Permie crear colecciones a partir de un pipeline (similar a tablas virtuales o projecciones de datos). Debe de ser el último de nuestra 
pipeline

### $unwind

Nos permite a partir de un documento que contenga un array como atributo, devolver el mismo documento duplicado tantas veces,
como valores tenga dicho array. Cada valor del array será devuelvo en el campo que hayamos definido en el $unwind.

Ejemplo:

```
   [
    {
      $unwind: {
        path: "$generated_documents",
        preserveNullAndEmptyArrays: true,
      },
    },
    {
      $project:
        {
          name: 1,
          collegiate_number: 1,
          generated_documents:
            "$generated_documents.document_url",
        },
    },
  ]

```
 
Esta pipeline lo que haría es por cada elemento dentro del array "$generated_documents",generaría un documento, duplicando
los valores de name,collegiate_number.

### $bucket

TODO


Ejemplo de un pipeline:

Obtener total de hombres/mujeres mayores de 65 años

```
    pipeline = [
        {"$match":{"age":{"$gt":65}}},
        {"$project":{"sex":1}},
        {"$group":{
            "_id":"$field",  // Campo del cual vamos a realizar la agrupación
            "computed_field":{"$accumulator":expresion} // $amulator es un operador que vamos a utilizar por cada grupo ,  por ejemplo $count
            }
        },
        {"$sort":{"total":-1}},
]

```

- Dentro del $group:
  - $field: Campo el cual vamos a usar como agrupador
  - computed_field: Nombre del campo calculado
  - $acumulator: Operador que vamos a realizar sobre el campo calculado ($count , $sum)
  - expresion: Valor o campo de la colección al cual vamos a aplicarle el acumulador. 


Obtener el cliente más viejo:

```
    pipeline = [
        {"$sort":{"$age":-1}},
        {"$limit":1},
]


```



