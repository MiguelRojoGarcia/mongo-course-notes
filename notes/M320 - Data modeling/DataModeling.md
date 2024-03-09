### DataModeling and Data relations.

A diferencia de una base de datos relacional, en Mongo no debemos de normalizar los datos. Esto no quiere decir que nuestras
colecciones sean un caos... La flexbilidad de mongo proviene de poder modificar la estructura de nuestros documentos de una misma
colección.

A la hora de modelizar nuestras entidades a un modelo de datos no relacional debemos de tener en cuenta los siguientes factores.

- Determinar la carga de trabajo: 
    
    Es decir, pensar en las posibles consultas que vava recibir nuestra colección y determinar los campos
    que la van a componer.
    
    De forma aproximada medir si nuestra colección va a crecer de forma exponencial o medir el
    posible tamaño futuro. Definir como se van a insertar,eliminar o actualizar los datos y con que frecuencia.

- En el caso de que tengamos que implementar relaciones, identificarlas y saber como se van a relacionar las colecciones
    entre sí (1-1, 1-N, N-N)

- Implementar patrones ya conocidos en Mongo.


### Relaciones en Mongo

Dentro del mundo no relacional de mongo, las relaciones se pueden gestionar de dos formar:

- Documentos embebido: Nuestro documento almacenará un sub-documento con los datos de la entidad a la que está relacionada.
    Recordemos que podemos almacenar un solo sub-documento (1-1) o un array con varios sub-documentos (1-N). La desventaja de 
    esta opción es la duplicidad de datos entre documentos.

- Almacenar referencia (DbRef o _id): Al igual que en un modelo relacional, podemos almacenar el id de la entidad a la que está relacionado.
    En el caso de mongo y por conveción , usaremos un objeto llamado DbRef que almacena, el _id , el nombre de la colección y de forma opcional,
    el nombre de la base de datos. De forma opcional, podemos almacenar únicamente el campo _id de nuestra tabla relacionada.

    Nota: En algunos lenguajes de progrmación, los DbRef pueden ser resueltos automáticamente, en caso contrario, nos toca resolverlos nosotros.


### $lookUp

Es un operador de agregación que nos permite hacer "joins" entre colecciones a partir de un campo específico:

``` 
{
   $lookup:
     {
       from: <collection to join>,
       localField: <field from the input documents>,
       foreignField: <field from the documents of the "from" collection>,
       as: <output array field>
     }
}

```

