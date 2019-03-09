from rest_framework import serializers
from .models import Resource, Target

class TargetSerializer(serializers.ModelSerializer):
	class Meta:
		model = Target
		fields = ('id',)		

class ResourceSerializer(serializers.ModelSerializer):
	target = TargetSerializer()
	class Meta:
		model = Resource
		fields = ('id', 'name', 'target', 'description', 'link')