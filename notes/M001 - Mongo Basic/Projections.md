### Projection

Nos permite limitar el numero de campos que devolvemos en las consultas:

Mostraremos unicamente el nombre y el email, descartando el _id que viene por defecto.

db.customers.find({},{name:1,email:1,_id:0})

db.customers.find({},{name:1,email:1,"address.city":1,_id:0})