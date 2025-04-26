import logging
from django.http import JsonResponse
from utils import get_db_handle

def get_all_sellers(request):
    try:
        db_handle, _ = get_db_handle("seller")  
        sellers_collection = db_handle["sellerDetails"]  

        sellers = list(sellers_collection.find({}, {"_id": 0}))  
        return JsonResponse({"sellers": sellers}, status=200)

    except Exception as e:
        logging.error("An error occurred: %s", str(e))
        return JsonResponse({"error": "An internal error occurred."}, status=500)
