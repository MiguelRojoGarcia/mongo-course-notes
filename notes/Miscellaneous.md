### Miscellaneous

Nos permite ver que processos se están ejecutando en el servidor. Adicionalmente se le puede pasar
un filtro para mostrar diferentes tipos de procesos.

``` db.currentOp() ```

En la Url de conexión, el valor de authSource=admin, nos inqica que queremos autenticarnos frente a la 
colección "admin"

``` mongodb://usuario:contraseña@host:puerto/?authSource=admin  ```

Nos permite obtener datos sobre una colección

``` db.getCollectionInfos({name:"CollectionName"}) ``` 
