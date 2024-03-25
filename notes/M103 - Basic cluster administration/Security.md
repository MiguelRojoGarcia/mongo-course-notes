### Seguridad

El método SCRAM es el método de autenticación básico que usaremos. Básicamente usaremos "user" + "password" + "data_base_autentication".

Es decir, Nos autenticaremos frente a una base de datos (admin) que almacenará las credenciales.

Para crear un usuario , seguiremos los siguientes pasos :

  - Entrar en la base de datos de admin:
    
    ``` use admin ```

  - Crear un usuario con el siguiente comando:
  
     ``` 
      db.createUser({
          user: "admin",
          pwd: passwordPrompt(),
          roles: [ 
              { role: "userAdminAnyDatabase", db: "admin" },
              { role: "readWriteAnyDatabase", db: "admin" }
              ]
      })
    ```
        
  - Paramos el servicio de mongo:
    
    ``` systemctl stop mongod ```

  - Actualizamos el fichero de configuración (/etc/mongod.conf) 
    
    ```
      security:
        authorization: enabled
    ```
  - Volvemos a arrancar mongo:
    
    ``` systemctl start mongod ```

Una vez establecidos los usuarios, podremos entrar en la terminal de la siguiente manera:

``` mongosh -u admin -p --authenticationDatabase admin```

Nota: Cuando creamos un usuario tenemos que definir sobre que base de datos está creado y al hacer login usaremos dicha
base de datos para el valor --authenticationDatabase


Podemos crear otros usuarios con diferentes roles : 
    
Ojo! Debemos de posicionarnos en la base de datos al crear el usuario haciendo un ``` use my-database-1 ```

   ``` 
      db.createUser({
          user: "contabilidad",
          pwd: passwordPrompt(),
          roles: [{ role: "readWrite", db: "nominas" }]
      })
      
```
   
``` 
      db.createUser({
          user: "rrhh",
          pwd: passwordPrompt(),
          roles: [{ role: "read", db: "nominas" },{ role: "readWrite", db: "empleados" }]
      })
```

### Obtener usuarios asociados a una base de datos.

Debemos de posicionarnos en la base de datos con el comando ``` use XXXX ``` y luego lanzar el comando

``` db.getUsers() ``` ó ``` db.getUser('nominas'') ```


### Gestion de roles

Roles : 

https://www.mongodb.com/docs/manual/reference/built-in-roles/

Todos los que lleven "Any" indica que pueden trabajar con cualquier base de datos.

- read
- readWrite
- dbAdmin
- dbOwner
- userAdmin
- clusterAdmin
- ClusterManager
- readAnyDatabase
- readWriteAnyDatabase
- userAdminAnyDatabase
- dbAdminAnyDatabase
- root (readWriteAnyDatabase + dbAdminAnyDatabase + userAdminAnyDatabase + clusterAdmin + restore + backup)


Podemos crear nuestros propios roles. Cuando creamos , por defecto lo creamos asociado a una base de datos concreta. No obstante,
podemos crear roles universales.

La información de los roles se almacena dentro de system.roles

Comando para crear un role:

```
  
  https://www.mongodb.com/docs/manual/reference/privilege-actions/
  https://www.mongodb.com/docs/manual/core/collection-level-access-control/
  
  use MongoCourse
  
  db.createRole({
      role: "ProductsInventoryManagerRole",
      privileges: [ 
            { resource: { db: "MongoCourse", collection: "products" }, actions: [ "find" ] },
      ],
      roles:[]
    })
    
    
   Creamos un usuario:
   
    db.createUser({
          user: "stock",
          pwd: passwordPrompt(),
          roles: [ 
              { role: "ProductsInventoryManagerRole", db: "MongoCourse" },
              ]
      })
  
```
Una vez creado el role, podemos asociarle un usuario con el siguiente comando:

```

use MongoCourse
db.grantRolesToUser("stock",[{role:"ProductsInventoryManagerRole",db:"MongoCourse"}])

```

Por último, obtenemos los datos del usuario para verificar si tiene ese rol:

```
use MongoCourse
db.getUsers()
 
```

Nota: Recuerda que SIEMPRE los roles se crean a nivel de base de datos, es decir podemos tener varios roles con el mismo nombre
pero asociado a varias bases de datos.