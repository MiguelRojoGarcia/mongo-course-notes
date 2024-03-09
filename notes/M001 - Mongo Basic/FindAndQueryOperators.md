### $eq

db.customers.find("name":{$eq:"Miguel"})
db.customers.find("name":"Miguel")

Nota: este operador tambien vale para cuando el campo a buscar es de tipo array

db.customers.find({"hobbies":"games"})

### $in
db.customers.find({"hobbies":{$in:["games","fishing"]}})
db.customers.find({"bank_movements.categories":{$in:["food"]}})

### $gt , $gte , $lt and $lte

db.customers.find({"bank_movements.amount":{$gt:50}})

### $elemMatch

Permite aplicar filtros dentro de un subdocumento tipo array

db.customers.find({"bank_movements":{$elemMatch:{"categories":{$in:["flowers"]}}}})

### $and y $or

db.customers.find({
    $and:[
        {"hobbies":{$in:["flowers"]}},
        {"bank_movements":{$elemMatch:{"categories":"flowers"}}}
    ]
})

// Buscamos aquellos usuarios que (se hayan gastado dinero en el hobbie X o que tengan el hobbie X) y (que hayan gastado dinero)
db.customers.find({
    $and:[
        { $or:[
            {"hobbies":"flowers"},
            {"bank_movements":{$elemMatch:{"categories":"flowers"}}}
        ] },
        { $or:[
            {"bank_movements.amount":{$lt:0.00}}
        ] }
        
    ]
})
