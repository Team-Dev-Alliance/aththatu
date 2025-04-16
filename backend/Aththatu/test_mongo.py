# test_mongo.py
from django.conf import settings
import django
import os

# Setup Django environment so settings work
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Aththatu.settings')
django.setup()

from utils import get_db_handle  # 🔁 Update this to match your app

def test_connection():
    db_handle, client = get_db_handle(settings.MONGO_DB_NAME["test_database"])
    print("✅ Successfully connected to MongoDB!")
    print("Available collections:", db_handle.list_collection_names())

if __name__ == '__main__':
    test_connection()
