from django.shortcuts import render
from django.http import HttpResponse
import json


def index(request):
    jsonList = []
    parsedData = []
    duplicates = []
    with open('/home/yt/workingLib/django/mysite/NetworkMonitor/data') as data:
        content = data.read().split('\n')
        for j in content:
		try:
			jsonList.append(json.loads(j))
			userData = {}
			ck = ''
    			for data in jsonList:
				ck = data['ip']
    				userData['ip'] = data['ip']
        			userData['country_code'] = data['country_code']
        			userData['country_name'] = data['country_name']
        			userData['region_code'] = data['region_code']
				userData['region_name'] = data['region_name']
        			userData['city'] = data['city']
        			userData['zip_code'] = data['zip_code']
        			userData['time_zone'] = data['time_zone']
				userData['latitude'] = data['latitude']
        			userData['longitude'] = data['longitude']
        			userData['metro_code'] = data['metro_code']
			if ck not in duplicates:
			    parsedData.append(userData)
			    duplicates.append(ck)
		except Exception as err:
			print(err)
			pass
    return render(request, '/home/yt/workingLib/django/mysite/NetworkMonitor/templates/view.html', {'data': parsedData})



