## Mongo Data base Indexes

Los índices nos permiten mejorar el rendimiento de nuestras consultas, sin ellos, las búsquedas se harían secuencialmente
(denominado un "collection scan"). A su vez reduce las operaciones de escritura y lectura en disco y por consiguiente los recursos.

Por defecto, las colecciones tienen como índice el campo _id.

El hecho de tener índices en una colección implica que con cada operación de escritura, los índices se deben de actualizar.
Esto puede suponer un problema con las colecciones de gran tamaño.


### ¿Como selecciona mongo un índice (Libro)?

En el caso hipotético que tengamos X índices bajo la misma colección , cuando lanzamos una consulta, Mongo analiza dicha consulta
e identifica posibles candidatos (esto lo hace analizando si los campos de la consulta pertenecen a un índice y si se aplica un orden).

Una vez obtenidos los indices candidatos, lanza varios planes de consulta (query plans) a modo de "carrera" y el que devuelva el resultado antes,
es el índice candiatos a ser finalista. Este proceso se queda cacheado hasta cierto tiempo o hasta que se actualice el valor de los 
índices.

Es posible saltarse dicho analisis usando el operador ``` $hint(index:1) ``` , aunque no es recomendable.


### ¿Cuando debemos o no de usar índices (Libro)?

Los indices son efectivos, cuando el tamaño de datos a devolver es pequeño. En caso de que los datos a devolver sean lotes,
grandes, no son eficientes ya que la búsqueda por indices primero tiene que consultar la tabla de indices, que puede ser enorme y luego
con los datos obteneidos de la tabla de indices buscar en la colección , que de igual manera es gigantesca. En este caso es más efectivo
el "COLLSCAN"


### Tipos de índices

- Índice de un solo campo (Single field)

- Índice compuesto (Compound)

  Cuando creamos un indice compuesto, debemos de prestar atención al primer campo que hemos definido en el indice ya que se define
  como el prefijo del índice, por lo que , para que nuestras consultas hagan uso de dicho indice compuesto, deben de hacer uso
  de nuestro prefijo.
  
  Por ejemplo:
  
  Índice compuesto : 
  
  ``` db.collection.createIndex(email:1,username:-1,card_number:1) ``` 
  
  El segundo parámetro hace referencia al tipo de orden que va a seguir.
  
  Nuestro prefijo sería el email ya que es el primer campo de nuestro indice compuesto.
  
  Existe una limitación con respecto a los indices compuestos y es que únicamente solo puede haber un Multikey index por 
  Compound index.
  
  Por ejemplo:
    
  ``` db.collection.createIndex(email:1,username:-1,hobbies:1) ```
  
  El orden a seguir al construir un indice compuesto debería de ser.

  - Equality (Reduce el nº de registros a procesar)
  - Sort (Evitamos que se tenga que hacer un SORT en memoria)
  - Range 

- Índice construido por los valores de un array (Multikey indexes). 
  
  Internamente mongo descompone el array y crea por cada elemento un indice de un solo campo. El array puede contener objetos o valores escalares (string , int...)
  Este tipo de índice no es recomendable ya que son menos eficientes.

Nota del libro: Los Indices parciales (Partial indexes) nos permites configurar un indice que unicamente sea usado si se cumple un criterio
establecido en el momento de la creación del índice.

``` 
db.restaurants.createIndex({ cuisine: 1, name: 1 },{ partialFilterExpression: { rating: { $gt: 5 } } })
db.users.createIndex({ email: 1 },{ partialFilterExpression: { $exist: true } })  
```

Más docu : https://www.mongodb.com/docs/manual/core/index-partial/

### Orden en los íncides (suspendido)

Los indices soportan operaciones de ordenación (ASC - DESC) , si el campo a ordernar se encuentra en un índice.

https://www.mongodb.com/docs/manual/tutorial/sort-results-with-indexes/

Esto significa que cuando creamos un indice (ya sea Single field o Compound) debemos de indicar el tipo de orden que va a llevar.

ASC = 1
DESC = -1

Ojo! En el caso de los Single field , un mismo indice ascendente , soporta ordenaciones ascendentes y descendentes. Esto
significa que no tenemos que crear el mismo índice dos veces para dar soporte a los dos tipos de ordenación.

En el caso de los Compound index, para que el índice haga su efecto en el momento de la ordenación, debemos de sequir el 
mismo orden que se ha definido en el índice compuesto

Ojo! Al igual que los Single field, en los Compound index soporta "traverse sort".

Ejemplo:

``` db.collection.createIndex(field_1:1,field_2:-1) ``` -> ``` db.collection.createIndex(field_1:-1,field_2:1) ```

Pero no : 

``` db.collection.createIndex(field_1:1,field_2:-1) ``` -> ``` db.collection.createIndex(field_1:-1,field_2:-1) ```

En este caso se tendrá que crear el mismo filtro pero con sort diferente.

Mongo hará un uso optimizado de estos indices si ordenamos siempre de forma ASC field_1 , pero podemos alternar el orden de field_2


``` db.collection.createIndex(field:1) ``` 

Si nuestro campo debe de ser único , debemos de añadir la opción {unique:true}. Esto normalmente es usado para campos que
almacenan email, nombres de usuario o nº identificativos.

``` db.collection.createIndex(email:1,{unique:1}) ```

## Gestión de Índices

Podemos obtener un listado de los índices de nuestra colección con la siguiente consulta:

``` db.collection.getIndexes() ```

Para poder revisar si nuestras consultas están haciendo uso de índices, debemos de añadir "explain()." a nuestras consultas.

``` db.collection.explain().find({email:"mrojo@gmail.com"}) ```

Obtendremos un documento (JSON) del cual debemos de prestar atención al campo "winningPlan" que es el cual nos va a decir
los pasos que ha seguido la query y en particular si ha hecho uso de índices. Debemos de prestar atención a la variable "stage"
que nos puede indicar lo siguiente : 

- IXSCAN: La consulta se ha ejecutado utilizando índices.

- COLLSCAN: La consulta no ha usado indices por lo que ha realizado una búsqueda secuencial.

- FETCH: Los documentos han sido leidos desde la colección.

- SORT: Los documentos han sido ordenados en memoria y no directamente usando los índices. Intentaremos evitar este caso mejorando el diseño de nuestros índices.
    
- PROJECTION_COVERED: Toda la información ha sido devuelta a partir del índice, no ha sido necesario obtener datos desde la memoria.
  Este resultado puede ser obtenido al usar una projección de campos que contenga los mismo campos que un índice compuesto.

Nota: Podemos usar el explain para experimentar cuál puede ser la mejor configuración para nuestro índices. Para ello , 
debemos de fijarnos en que el valor de nReturned debe de estar cerca de totalKeysExamined


Nota del libro: Cuando diseñamos indices compuestos, debemos de dejar como prefijo, aquellos campos los cuales vayamos
a realizar búsquedas de igualdad o aquellos campos que van a ser más selectivos.

Nota del libro: Con respecto a la cardinalidad de nuestros índices, daremos preferencia a los campos que nos permitan obtener una alta
cardinalidad, es decir que pueden ser mas selectivos.


### Operadores no eficientes

Los operadores ``` $ne ``` , ``` $not ``` o ``` $nin ``` en la mayoria de los casos deben de hacer un collscan, por lo que no se recomienda usarlos.
En todo caso se pueden usar si previamente se ha usado un filtro hacia un índice de igualdad para reducir el tamaño de los documentos a procesar.


### Borrado de índices

``` db.collection.dropIndex(email_1) ``` o  ``` db.collection.dropIndex({email:1}) ```

Se recomienda borrar unicamente los índices redundantes y los no usados ya que un número elevado de índices afecta en las
operaciones de escritura. 

Podemos deshabilitar un índice con el siguiente comando: 

``` db.collection.hideIndex(email_1) ``` o ``` db.collection.hideIndex({email:1}) ```

Esto nos permite que mongo no use el índice pero lo mantiene actualizado. Es menos costoso ocultar un índice que borrarlo y volver a 
recrearlo ya que esto no es instantaneo y consume bastantes recursos.


## Mongo search Indexes

Esta opción únicamente está disponible en Mongo Altas.

Indices usados para indicar que registros son relevantes para el resultado de una consulta.

Por defecto la busqueda se realizará en todos los campos de la colección (Dynamic Mapping) pero se puede configurar para
que unicamente busque en campos determinados (Static Mapping). Esto ayuda a que las consultas sean más eficientes.

Usaremos el stage $search para construcir nuestras consultas. Dentro del stage, podemos hacer uso del operador "compound"
que nos ofrece las siguientes opciones : 

- must : Incluye todos los documentos que coinciden exactamente con la consulta.

- mustNot: Lo contrario de must.

- should: Nos permite establecer un peso al resultado , pudiento medir el match.

- filter: Descarta aquellos resultados que no coinciden con la consulta.

Ejemplo : 

```
 
 $search {
  "compound": {
    "must": [{
      "text": {
        "query": "field",
        "path": "habitat"
      }
    }],
    "should": [{
      "range": {
        "gte": 45,
        "path": "wingspan_cm",
        "score": {"constant": {"value": 5}}
      }
    }]
  }
}
   
 ```

https://www.mongodb.com/docs/atlas/atlas-search/operators-and-collectors/