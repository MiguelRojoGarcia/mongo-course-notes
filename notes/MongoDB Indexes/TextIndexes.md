### Índices de tipo texto

Nos permiten realizar búsquedas de texto parcial sobre un índice que está compuesto por varios campos (nombre + apellidos).

Una colección únicamente puede tener un solo índice de tipo texto.

Para crear un índice de tipo texto usaremos el siguiente comando:

``` db.collection.createIndex({field:"text"},{default_language:"spanish"}) ```

Setearemos el default_language para mejorar la tokenización

Para realizar búsquedas haciendo uso del índice, ejecutaremos la siguiente consulta:

``` db.collection.find({$text:{$search:'some text...'}}) ```

Podemos obtener un scoring para ordernar nuestro resultado:

``` db.collection.find({$text:{$search:'some text...'}},{scoring:{$meta:"textScore"}}) ```

### ¿Como funciona?

Cuando creamos índice de tipo texto, mongo tokeniza el contenido , creando índices individuales por cada palabra. A su 
vez aplica un proceso llamado "steam" que mejora el guardado de cada palabra reduciéndola (se almacena únicamente la raiz de la palabra)

Nota del curso: Al realizar las búsquedas , no busca de forma exacta a priori. Si no que al tokenizar el texto, elimina aquellas palabras
que carecen importancia (artículos ,"es",...) y busca las ocurrencias. Por ejemplo si buscamos el texto "la casa azul" , buscará aquellos
elementos que contengas "casa" y "azul", o solo "casa" y solo "azul".

Si queremos que realice una búsqueda exacta, usaremos el siguiente comando:

``` db.collection.find({$text:{$search:"\"full text"\"}}) ```

Podemos realizar una búsqueda que haga una exclusión de una cadena:

``` db.collection.find({$text:{$search:"Jhon -Doe"}}) ```

Esta consulta nos buscará aquellos documentos que contengan "Jhon" pero que no contengan "Doe" 

Nota laboratorio: 

Al realizar pruebas, me he dado cuenta que los índices de tipo texto, no funcionan tan bien como esperaba ya que es menos preciso que un $regex.
Si es verdad qye para colecciones inmensas con campos con mucho texto, puede ser util.



