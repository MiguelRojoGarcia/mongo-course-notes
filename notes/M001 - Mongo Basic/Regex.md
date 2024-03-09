### Regex

https://www.mongodb.com/docs/manual/reference/operator/query/regex/

Permite realizar búsquedas utilizando expresiones regulares

  ``` { <field>: { $regex: /pattern/, $options: '<options>' } } ```

Opciones:

 - i: Desactiva el case sensitive y realiza la búsqueda tanto en mayúsculas como en minúsculas.

 - m: Busca en patrones multilinea.

 - x: Ignora los espacios en blanco.

 - s: Permite usar el punto dentro de la expresión regular.


De forma opcional, podemos usar ``` { <field>: /<pattern>/ } ```, pero tiene algunas restricciones.

  - El operador simple, podemos combinarlo con el operador $in:

  ``` { name: { $in: [ /^acme/i, /^ack/ ] } }  ``` , pero no podemos usarlo con el operador $regex.

  
  - Si queremos utlizar una lista de condicionales separados por coma (AND) , debemos de usar el
    operador $regex.


  - Si queremos usar las opciones x (ignorar espacios en blanco) y s (permitir el . dentro de la expresión regular)
  

    ``` { name: { $regex: /acme.*corp/, $options: "si" } }  ```


Podemos combinar el operador $regex con el $not para obtener aquellos documentos que NO cumplan con 
la expresión regular:

  ``` db.inventory.find( { item: { $not: { $regex: "^p.*" } } } )   ```
  

Ejemplo de un LIKE (MYSQL):

  Registros los cuales el nombre de usuario acabe en mrojo:

    Mongo : ``` db.users.find( { name: { $regex: /mrojo$/ } } )  ```

    Mysql: ``` SELECT * FROM users WHERE name LIKE '%mrojo'  ```

  Registros los cuales empiecen por Miguel
  
    Mongo : ``` db.users.find( { name: { $regex: /^Miguel/ } } )  ```

    Mysql: ``` SELECT * FROM users WHERE name LIKE 'Miguel%'  ```
