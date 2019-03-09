from django.db import models

class Resource(models.Model):
	name = models.CharField(max_length=255, blank=False, unique = True)
	target = models.ManyToManyField(Target)
	description = models.CharField(max_length=255)
	link = models.CharField(max_length=255)

	def __str__(self):
		return self.name




class Target(models.Model):
	name = models.CharField(max_length=255, blank=False, unique =True)

	def __str__(self):
		return self.name
