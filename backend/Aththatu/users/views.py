from django.http import JsonResponse
from utils import get_db_handle
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json

def get_profile_by_username(request, username):
    db_handle, _ = get_db_handle(settings.MONGO_DATABASES['user'])
    profile_collection = db_handle['profile']
    profile = profile_collection.find_one({"username": username})

    if profile:
        profile['_id'] = str(profile['_id'])  # Convert ObjectId to string for JSON
        return JsonResponse(profile)
    else:
        return JsonResponse({'error': 'User not found'}, status=404)
    
    
# Remove this exempt after testing, the inbuilt verification of django will takeover
@csrf_exempt
def create_user(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            username = data.get('username')
            email = data.get('email')
            passwordhash = data.get('passwordhash')

            db_handle, _ = get_db_handle(settings.MONGO_DATABASES['user'])
            profile_collection = db_handle['profile']

            result = profile_collection.insert_one({
                "username": username,
                "email": email,
                "passwordhash": passwordhash
            })

            return JsonResponse({'message': 'User created'}, status=200)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=400)
    
    return JsonResponse({'error': 'Invalid request method'}, status=405)
