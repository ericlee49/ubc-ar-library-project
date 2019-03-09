from django.contrib import admin
from .models import Resource
from .models import Target



class ResourceAdmin(admin.ModelAdmin):
	list_display = ("name", "target", "link")
	search_fields = ["name", "target__name"]
	list_filter = ('target',)
	class Meta:
		model = Resource


class TargetAdmin(admin.ModelAdmin):
	list_display = ("id", "name")
	class Meta:
		model = Target

admin.site.register(Resource, ResourceAdmin)
admin.site.register(Target, TargetAdmin)

admin.site.site_header = "UBC Library AR"