from django.urls import path
from . import views

urlpatterns = [
    path('profile/<str:username>/', views.get_profile_by_username, name='get_profile'),
    path('createprofile/', views.create_user, name='create_user')
]
