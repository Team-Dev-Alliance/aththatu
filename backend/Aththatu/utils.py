from pymongo import MongoClient
from django.conf import settings
import certifi

def get_db_handle_Chathu():
    """Returns MongoDB database handle and client"""
    client = MongoClient(
        settings.MONGO_URI_CHATHU,
        tlsCAFile=certifi.where()  # For Atlas SSL
    )
    db = client[settings.MONGO_DATABASES["chatsystem"]]  # ✅ Corrected line
    return db, client
