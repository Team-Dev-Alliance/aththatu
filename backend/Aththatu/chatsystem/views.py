# chatsystem/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from utils import get_db_handle_Chathu
import datetime

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_messages(request):
    db, _ = get_db_handle_Chathu()
    messages = list(db['group_messages'].find(
        {"group_name": "public-chat"},
        {"_id": 0, "author": 1, "body": 1, "created": 1},
        sort=[("created", -1)],
        limit=30
    ))
    return Response({"messages": messages})

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def send_message(request):
    db, _ = get_db()
    message = {
        "group_name": "public-chat",
        "author": request.user.username,
        "body": request.data.get("message"),
        "created": datetime.datetime.utcnow()
    }
    db['group_messages'].insert_one(message)
    return Response({"status": "success"})


@api_view(['POST'])
@permission_classes([AllowAny])  # Allow registration without auth
def create_user(request):
    db, _ = get_db_handle_Chathu()
    username = request.data.get('username')
    password = request.data.get('password')  # In production, hash this!
    
    if not username or not password:
        return Response({"error": "Username and password required"}, status=400)
    
    try:
        # Check if username exists
        if db.users.find_one({"username": username}):
            return Response({"error": "Username already exists"}, status=400)
            
        user_id = db.users.count_documents({}) + 1
        db.users.insert_one({
            "user_id": user_id,
            "username": username,
            "password": password,  # REMOVE IN PRODUCTION - use hashing
            "created_at": datetime.datetime.utcnow()
        })
        return Response({
            "status": "success",
            "user_id": user_id,
            "username": username
        })
    except Exception as e:
        return Response({"error": str(e)}, status=500)
    
    
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_chat_group(request):
    db, _ = get_db_handle_Chathu()
    other_user_id = request.data.get('other_user_id')
    
    if not other_user_id:
        return Response({"error": "other_user_id required"}, status=400)
    
    try:
        # Get current user
        current_user = db.users.find_one({"username": request.user.username})
        if not current_user:
            return Response({"error": "User not found"}, status=404)
            
        # Get other user
        other_user = db.users.find_one({"user_id": int(other_user_id)})
        if not other_user:
            return Response({"error": "Other user not found"}, status=404)
        
        # Create sorted user pair (avoid duplicate chats)
        user1, user2 = sorted([current_user['user_id'], other_user['user_id']])
        
        # Check if chat exists
        existing_chat = db.chat_groups.find_one({
            "user_1": user1,
            "user_2": user2
        })
        
        if existing_chat:
            return Response({
                "status": "exists",
                "group_name": existing_chat["group_name"]
            })
        
        # Create new chat
        group_name = db.chat_groups.count_documents({}) + 1
        db.chat_groups.insert_one({
            "group_name": group_name,
            "user_1": user1,
            "user_2": user2,
            "created_at": datetime.datetime.utcnow()
        })
        
        return Response({
            "status": "success",
            "group_id": group_name,
            "participants": [user1, user2]
        })
    except Exception as e:
        return Response({"error": str(e)}, status=500)

