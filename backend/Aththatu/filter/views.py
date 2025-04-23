from backend.Aththatu.utils import get_db_handle
import json
from django.http import JsonResponse
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
from django.http import JsonResponse
from django.conf import settings
from bson.json_util import dumps
from math import radians


@csrf_exempt
def get_closet_seller_address(request):
    if request.method == 'GET':  # Change to POST since we're using the body
        try:
            # Parse the JSON body
            body = json.loads(request.body)
            user_lat = float(body.get("latitude"))
            user_lng = float(body.get("longitude"))
            limit = int(body.get("limit", 5))  # Default to 5 closest addresses

            # Connect to MongoDB
            db_handle, _ = get_db_handle(settings.MONGO_DATABASES['seller'])
            seller_address = db_handle['address']

            # Geospatial query using $near
            closest = seller_address.find({
                "location": {
                    "$near": {
                        "$geometry": {
                            "type": "Point",
                            "coordinates": [user_lng, user_lat]
                        }
                    }
                }
            }).limit(limit)

            # Convert cursor to list and return JSON response
            return JsonResponse({"closest": json.loads(dumps(list(closest)))}, safe=False)

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=405)
