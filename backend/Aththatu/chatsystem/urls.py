from django.urls import path
from .views import *

urlpatterns = [
    #path('',chat_view, name='home')
    path('createUser/', create_user, name='create_user'),
    path('createGroupChat/', create_chat_group, name='create_chat'),
    path('<str:group_name>/getMessages/', get_messages, name='get_messages'),
    path('sendMessage/', send_message, name='send_message'),

]
