import json
import requests

# set up the request parameters
params = {
    "api_key": "9BC86088FFFE44F188284F65D303F1DD",
    "search_type": "places",
    "output": "json",
    "hl": "tr",
    "q": "restaurant",
    "gl": "tr",
    "location": "Ankara,Ankara,Turkey",
    "google_domain": "google.com.tr",
}

# make the http GET request to Scale SERP
api_result = requests.get("https://api.scaleserp.com/search", params)

# print the JSON response from Scale SERP
print(json.dumps(api_result.json()))
