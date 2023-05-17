from flask import Flask, jsonify
import json
from classes.Utility import *
from classes.Supabase import *



app = Flask(__name__)

@app.route('/')
def home():

    with open('nearestStation.json') as f:
        data = json.load(f)

    return jsonify(data)

@app.route('/cords=<string:cords>')
def cordinates(cords):

    cordsArray = cords.split(',')
    lat = float(cordsArray[0])
    lon = float(cordsArray[1])

    report = createReport(lat, lon)
    return report

@app.route('/user=<string:user>/add=<string:water>')
def user(user, water):

    water = int(water)

    #Access the SUPABASE client
    url = "https://vrugylomdozzwscsaelr.supabase.co"
    key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZydWd5bG9tZG96endzY3NhZWxyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MzcyNTU1NiwiZXhwIjoxOTk5MzAxNTU2fQ.8Fiu6YZtZBX1ZSZ-N84Q3LZvK3ukzfjJC0lERR_JOHI"
    supabase: Client = create_client(url, key)

    report = {'user': user}

    if water == -1:
        curWater = getLitters(supabase, user)
        report['liters'] = curWater
        report['report_type'] = 'lifetime'
    elif water == 0:
        curWater = getDailyLitters(supabase, user)
        report['liters'] = curWater
        report['report_type'] = 'daily'
    elif water > 0:
        addLitters(supabase, user, water)
        curWater = getDailyLitters(supabase, user)
        report['liters'] = curWater
        report['report_type'] = 'daily'


    return json.dumps(report)





