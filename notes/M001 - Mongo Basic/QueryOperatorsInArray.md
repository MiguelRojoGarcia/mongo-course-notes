### Query operators in array and objects.

Para operaciones de búsqueda simple detro de un array podemos usar los siguientes operadores:

- Buscar un valor dentro del array X: 
    
    ``` db.ciudades.find({"X":"something") ```
    
    ``` db.ciudades.find({"X":{$gt:10}) ```

- Buscar un valor dentro del array X y con posición específica: 
    
    ``` db.ciudades.find({"X.1":"something") ```


Nota del libro: Las búsquedas por rango no son efectivas usando los peradores $gt-$lt. Para ello usaremos el $elemenMatch


Nota y cuidado!:

Las búsquedas dentro de array de objetos se hacen de la misma manera:

    ``{consejeros:{$elemMatch:{edad:{$gt:60}}}}`` ==     ``{consejeros.edad:{$gt:60}}``
 

Para realizar búsquedas dentro de documentos anidados, usaremos el punto, para hacer referencia al valor del objecto el
cual queremo buscar : 

``` db.ciudades.find({"alcalde.edad":{$gt:60}}) ```


### Operadores de búsqueda en arrays:

https://www.mongodb.com/docs/manual/reference/operator/query/in/

- $in: Nos permite buscar aquellos documentos que coincidan con algun valor del array proporcionado. Funciona de forma 
       similar a un OR. Para mejorar el rendimiento de la búsqueda, podemos crear un índice en el campo seleccionado.
        

    ``` {paises:{$in:["usa","israel"]}} ```  

    Esta consulta devolvería aquellos registros en los cuales en campo "paises" contenga "usa" o "israel"

https://www.mongodb.com/docs/manual/reference/operator/query/all/

- $all: Similar al $in pero es más restrictivo, ya que todos los elementos proporcionados deben de aparecen en el 
        array del documento
    

    ``` {paises:{$all:["usa","israel"]}} ```

    Esta consulta devolvería aquellos registros en los cuales en campo "paises" contenga "usa" e "israel"


- $size: Nos permite buscar aquellos arrays que tengan un tamaño exacto al proporcionado. Este operador no puede ser 
         combinado con $gt o $lt. Para ello debemos de almacenar en un campo el tamaño actual del array.



https://www.mongodb.com/docs/manual/reference/operator/query/elemMatch/

- $elemenMatch: Permite aplicar un filtro a un elemento de un array. Es decir, busca aquellos elementos de un array, que
    coincidan con el filtro prorcionado. Funciona igual para un array de objectos.
    

    ``` {invocies:{$elemMatch:{total:{$gt:30}}}} ```
    
    Obtiene el listado de facturas cuyo total sea mayor a 30

    `` {change_log:{$elemMatch:{"user_id":ObjectId('649a9a3248f9a5e0b87ce83d')}}} ``

    Busca aquellos documentos en los cuales el usuario proporcionado haya realizado cambios.

    ``{consejeros:{$elemMatch:{edad:{$gt:60}}}}``

    Realiza una búsqueda dentro de un array de objectos cuyo elemento tenga una edad superior a 60