from django.shortcuts import render
from rest_framework import generics
from .serializers import ResourceSerializer
from .models import Resource


class CreateView(generics.ListCreateAPIView):
	'''queryset = Resource.objects.all()'''
	serializer_class = ResourceSerializer

	def get_queryset(self):
		queryset = Resource.objects.all()
		target = self.request.query_params.get('target', None)
		if target is not None:
			queryset = queryset.filter(target = target)
		return queryset		

	def perform_create(self, serializer):
		"""Save the post data when creating a new resource."""
		serializer.save()	

class DetailsView(generics.RetrieveUpdateDestroyAPIView):
	queryset = Resource.objects.all()
	serializer_class = ResourceSerializer