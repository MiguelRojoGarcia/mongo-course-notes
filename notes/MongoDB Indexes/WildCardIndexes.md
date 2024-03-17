### Índices de tipo wildcard

https://www.mongodb.com/docs/manual/core/indexes/index-types/index-wildcard/

Nos permiten crear índices sobre campos que pueden o no existir. Esto es muy util cuando almacenamos estructuras de datos
dinámicas.

¿Cuando debemos de hacer uso de ellos?

- Cuando las consultas hacia tus colecciones varian entre documentos.
- Cuando se hacen consultas de forma repetida a documentos que contienen campos no definidos o que pueden o no existir.
- Si vas a realizar consultas similares a diferentes documentos que contiene campos similares.

Recordemos los índices pueden reducir el rendimiento en las operaciones de escritura ya que se debe de actualizar con cada 
operación (Crear , actualizar, borrar...)

Para crear un índice de tipo wildcard usaremos el siguiente comando:

Para indexar todos los campos de la colección:

``` db.collection.createIndex({"$**":1}) ```

Para indexar sub-estructuras:

``` db.collection.createIndex({"<field>.$**":1}) ```