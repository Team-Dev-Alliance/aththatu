from django.urls import path
from . import views

urlpatterns = [
    path('closet/seller', views.get_closet_seller_address, name="seller_closet_address")
]