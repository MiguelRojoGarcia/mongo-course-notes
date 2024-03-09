### Create user

Role actions : 

userAdminAnyDatabase
readWriteAnyDatabase
readWrite

db.createUser({
    user: "tom",
    pwd: passwordPrompt(),
    roles: [ 
        { role: "userAdminAnyDatabase", db: "admin" }
        , "root"]
})