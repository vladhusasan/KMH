import requests
from datetime import datetime
import time
import json
import schedule

def worker():
    URL = "http://192.168.100.3:1997/locatie"
    r = requests.get(url = URL)

    # extracting data in json format
    data = r.json()
    print(data)
    if data["success"]=='success' and data["results"]is not None:
        current_date=datetime.now()
        for elem in data["results"]:
            try:
                timevalue_format=datetime.strptime(elem["timp"], '%Y-%m-%d %H:%M:%S.%f')
                delta_time=current_date-timevalue_format
                if delta_time.days>=1:
                    response = requests.delete(URL, json={'latitudine':str(elem["latitudine"]),'longitudine':str(elem["longitudine"]),'nume':elem["nume"]})
                    #print(response.json())
            except:
                pass
worker()
schedule.every(5).minutes.do(worker)
while 1:
    schedule.run_pending()
    time.sleep(1)