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
            phonenumbers = data.get('phonenumbers', [])
            profileimagelink = data.get('profileimagelink')
            passwordhash = data.get('passwordhash')
            address = data.get('address', {})
            
            # Basic validation
            if not username or not passwordhash:
                return JsonResponse({'error': 'Username and password are required'}, status=400)
            
            db_handle, _ = get_db_handle(settings.MONGO_DATABASES['user'])
            profile_collection = db_handle['profile']
            
            # Check if username already exists
            if profile_collection.find_one({"username": username}):
                return JsonResponse({'error': 'Username already exists'}, status=409)

            # Create user document
            user_doc = {
                "username": username,
                "email": email,
                "passwordhash": passwordhash,
                "profileimagelink": profileimagelink,
                "phonenumbers": phonenumbers,
                "address": address
            }

            result = profile_collection.insert_one(user_doc)

            return JsonResponse({
                'message': 'User created successfully',
                'user_id': str(result.inserted_id)
            }, status=201)
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=400)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    
    return JsonResponse({'error': 'Invalid request method'}, status=405)
