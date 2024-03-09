### Aggregations Examples

- Contar elementos distintos de una colección 
    
    ``` SELECT COUNT(event_id) FROM EventApplications GROUP BY Eventid ```

    ``` 
       db.EventApplication.aggregate( [
         {
           $group: {
              _id: "$event_id",
              num_applications: { $sum:1 }
           }
         },
         { $sort: { num_applications: -1 } }
      ] )    
  
    ```

- Concatenar elementos, eliminando los espacios en blanco de los laterales
    
    ``` SELECT CONCAT(name,surname_1,surname_2) as FullName FROM Collegiates ```
  
    ```
        db.Collegiate.aggregate( [
          {
            $project: {
               full_name: {
                  $concat:[
                      {$rtrim:{input:{$ltrim:{input:"$name"}}}},
                      " ",
                      {$rtrim:{input:{$ltrim:{input:"$surname_1"}}}},
                      " ",
                      {$rtrim:{input:{$ltrim:{input:"$surname_2"}}}},
                  ]}
            }
          }
          
        ] )
   ```