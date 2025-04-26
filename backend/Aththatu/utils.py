from pymongo import MongoClient
from django.conf import settings

def get_db_handle(db_name):
    client = MongoClient(settings.MONGO_URI)
    db_handle = client[db_name]
    return db_handle, client

