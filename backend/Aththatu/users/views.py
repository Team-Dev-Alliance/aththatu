from django.http import JsonResponse
from utils import get_db_handle
from django.conf import settings

def get_profile_by_username(request, username):
    db_handle, _ = get_db_handle(settings.MONGO_DATABASES['user'])
    profile_collection = db_handle['profile']
    profile = profile_collection.find_one({"username": username})

    if profile:
        profile['_id'] = str(profile['_id'])  # Convert ObjectId to string for JSON
        return JsonResponse(profile)
    else:
        return JsonResponse({'error': 'User not found'}, status=404)