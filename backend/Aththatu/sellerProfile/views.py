from django.http import JsonResponse
from utils import get_db_handle

def get_all_sellers(request):
    try:
        db_handle, _ = get_db_handle("seller")  
        sellers_collection = db_handle["sellerDetails"]  

        sellers = list(sellers_collection.find({}, {"_id": 0}))  
        return JsonResponse({"sellers": sellers}, status=200)

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
