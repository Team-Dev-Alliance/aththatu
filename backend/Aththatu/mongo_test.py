# mongo_test.py
from pymongo import MongoClient
import certifi
import os
from dotenv import load_dotenv

# Load environment variables (needed if not loaded via Django settings)
load_dotenv()

MONGO_URI_Chathu = os.getenv("MONGO_URI_Chathu")

def test_mongo_connection():
    try:
        client = MongoClient(MONGO_URI_Chathu, tlsCAFile=certifi.where())
        client.admin.command('ping')
        print("✅ MongoDB connection successful!")
    except Exception as e:
        print("❌ MongoDB connection failed:", e)

if __name__ == "__main__":
    test_mongo_connection()
