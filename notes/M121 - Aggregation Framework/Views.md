### Views / On demand materialized views

Las vistas son colecciones únicamente de lectura, que son creadas a partir de agregaciones.

Exsites dos tipos de vistas: 

- Vistas standard: Consiste en queries almacenadas que son ejecutadas previamente al realizar una consulta hacia la vista.
    Su rendimiento es menor ya que cada vez que realicemos una consulta hacia dicha vista, lanzaremos una consulta previa
    para construirla.
    
    Para construir una vista, ejecutaremos el siguiente comando:
    
    ```
        db.createView(
          "<viewName>",
          "<source>",
          [<pipeline>],
    )      
    ```
    
    En la cual podemos ver que tenemos que proporciona un nombre de vista, una colección a la que va hacer referencia y por último,
    una pipeline que va a construir los datos de nuestra vista.

- Vistas bajo demanda (on-demand materialized views): Vistas almacenadas en disco que se comportan exactamente igual quue una colección.
     Al igual que una vista normal, es construida a partir de una pipeline, pero usando al final de la pipeline el comando $out.

     Los índices de las vistas, son heredadas de las colecciones a la que pertenecen, por lo que no se pueden manipular. En el caso de las 
     vistas materializadas, se pueden añadir índices ya que estas están almacenadas en disco.

Con respecto al rendimiento, las vistas materializadas son más rápidas ya que están "cacheadas" en disco a diferencia de las
vistas normales ya que estas previamente han de ser ejecutadas.