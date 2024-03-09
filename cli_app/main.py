import os
import pprint
from dotenv import load_dotenv
from src.database.mongoclient import MongoClient
load_dotenv()

# Instance mongo client
client = MongoClient(mongo_database=os.getenv("MONGO_INITDB_DATABASE"), mongo_uri=os.getenv("MONGO_URI"))

collegiates_collection = client.db.Collegiate

pipeline = [
    {"$project":
        {
            "_id": 0,
            "name": {"$concat": ["$name", " ", "$surname_1"]},
            "gender": "$gender.$id",
            "city": "$address.city.$id",
            "other_city": {"$first": "$other_addresses.city"},
        }
    },
    {"$unwind": "$other_city"},
    {"$limit": 10}
]

results = collegiates_collection.aggregate(pipeline=pipeline)

for result in results:
    pprint.pprint(result, indent=4)

client.client.close()
exit(1)
