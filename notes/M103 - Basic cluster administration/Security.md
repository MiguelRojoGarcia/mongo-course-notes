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


Roles : 

https://www.mongodb.com/docs/manual/reference/built-in-roles/

- readAnyDatabase
- readWriteAnyDatabase
- userAdminAnyDatabase
- dbAdminAnyDatabase
- root
    