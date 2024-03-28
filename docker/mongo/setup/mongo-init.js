db.auth("admin","S3cr3t!")

//priority : Decides if is primary o secondary
rs.initiate(
    rsconf = {
    _id: "rs1",
    members: [
        {_id: 0, host: "mongo_course_database_master","priority" : 1,},
        {_id: 1, host: "mongo_course_database_replica_1","priority" : 0.5},
        {_id: 2, host: "mongo_course_database_replica_2","priority" : 0.5}
    ]
}
)
