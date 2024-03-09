import pymongo


class MongoClient:

    db = None
    client = None

    def __init__(self, mongo_database: str, mongo_uri: str):
        self.client = pymongo.MongoClient(mongo_uri)
        self.db = self.client[mongo_database]
