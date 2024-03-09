### Aggregations methods

- countDocuments(): Cuenta los documentos resultante de una consulta
    
    ``` db.collection.countDocuments(<filter>) ```

- distinct: Elimina los valores duplicados de un resultado.
    
  ``` db.collection.distinct(<field>,<query>) ```

### Aggregations operators (not all of them but more usefully) 

https://www.mongodb.com/docs/manual/reference/operator/aggregation/

Operadores aritméticos:

- $multiply: Permite multiplicar los valores dados dentro del array:

  ``` { $multiply: [ x, y, ... ] }  ```

- $divide: Permite dividir los valores dados dentro del array:

  ``` { $divide: [ x, y, ... ] }  ```

- $abs: Valor absoluto de un número

  ``` { $abs: [ x ] }  ```

- $ceil: Devuelve el valor entero más cercano a un float

  ``` { $ceil: [ x.xxx ] }  ```

- $round: Redondea una cantidad

  ``` { $ceil: [ x.xxx , <place> ] }  ```


Operadores de tratamiento de cadenas:

- $concat: Concatena una cadena
  
  ``` { $concat: [ "$fieldA"," ","$fieldB" ] }  ```

- $ltrim/$rtrim: Elimina los espacios en blanco laterales de una cadena
  
  ``` {$rtrim:{input:{$ltrim:{input:"$fieldA"}}}},  ```
