# from pymongo import MongoClient
# from django.conf import settings

# def get_db_handle(db_name):
#     client = MongoClient(settings.MONGO_URI_Chathu)
#     db_handle = client[db_name]
#     return db_handle, client

# db = get_db_handle()
# backend/db_utils.py
from pymongo import MongoClient
from django.conf import settings
import certifi

def get_db_handle_Chathu():
    """Returns MongoDB database handle and client"""
    client = MongoClient(
        settings.MONGO_URI_Chathu,
        tlsCAFile=certifi.where()  # For Atlas SSL
    )
    db = client[settings.MONGO_CHAT_DATABASE]
    return db, client