from django.urls import path
from . import views

urlpatterns = [
    path('sellerDetails/', views.get_all_sellers, name='get_all_sellers'),
]