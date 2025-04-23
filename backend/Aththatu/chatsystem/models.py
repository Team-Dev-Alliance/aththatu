
from django.db import models
from django.contrib.auth.models import User

# Create your models here.
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

# class ChatGroup(models.Model):
#     group_id = models.AutoField(primary_key=True) 
#     user1 = models.ForeignKey(
#         User, 
#         on_delete=models.CASCADE,
#         related_name='users'
#     )
#     user2 = models.ForeignKey(
#         User,
#         on_delete=models.CASCADE,
#         related_name='users'
#     )
#     created_at = models.DateTimeField(auto_now_add=True)

#     class Meta:
#         unique_together = [('user1', 'user2')]  # Ensures unique pairs
#         verbose_name = "Private Chat"
#         verbose_name_plural = "Private Chats"

#     def __str__(self):
#         return f"Chat between {self.user1.username} and {self.user2.username} (ID: {self.group_id})"
# class GroupMessage(models.Model):
#     group = models.ForeignKey(ChatGroup, related_name='chatmessages', on_delete=models.CASCADE)
#     author =  models.ForeignKey(User, on_delete=models.CASCADE)
#     body = models.CharField(max_length=300)
#     created = models.DateTimeField(auto_now_add=True)
    
#     def __str__(self):
#         return f'{self.author.username} : {self.body}'
    
#     class Meta:
#         ordering = ['-created']
    