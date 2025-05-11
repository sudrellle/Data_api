from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin
)
# Create your models here.
class UserManager(BaseUserManager):
    def create_user(self,email,password=None,**extra_field):
        user=self.model(email=email,**extra_field)
        user.set_password(password)
        user.save(using=self._db)


class User(AbstractBaseUser,PermissionsMixin):
    email=models.EmailField(max_length=255,unique=True)
    name=models.CharField(max_length=255)
    is_active=models.BooleanField(default=True)
    is_staff=models.BooleanField(default=False)
    objects=UserManager()
    USERNAME_FIELD='email'

