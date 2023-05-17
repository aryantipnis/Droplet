from classes.IntializeData import *
import json
from supabase import create_client, Client

"""
Given a list of all buildings sorted by how close they are in feet to the cords we provided
"""
def nearestBuilding(buildingList, cords):

    distanceMap = {}

    for building in buildingList:
        buildingCords = building.cords
        distance = cords.distance(buildingCords)
        distanceMap[building] = distance
    
    sortedMap = sorted(distanceMap.items(), key=lambda x:x[1])

    return sortedMap

def updatedBuildingCount(buildingId):
    url = "https://vrugylomdozzwscsaelr.supabase.co"
    key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZydWd5bG9tZG96endzY3NhZWxyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MzcyNTU1NiwiZXhwIjoxOTk5MzAxNTU2fQ.8Fiu6YZtZBX1ZSZ-N84Q3LZvK3ukzfjJC0lERR_JOHI"
    supabase: Client = create_client(url, key)

    #Update the total liters column
    response1 = supabase.table('Buildings').select('QueryCount').match({
            'BuildingId': buildingId
        }).execute().data[0]
    
    curCount = response1['QueryCount']

    print(response1)

    response2  = supabase.table('Buildings').update({
            'QueryCount': curCount + 1
        }).match({
            'BuildingId': buildingId
        }).execute()


    
def print5buildings(list): 

    

    finalReturn = {}
    finalReturn['places'] = []

    allBuildings = []

    for i in range(0, 5):
        buildingTuple = list[i]
        
        buildingObject = buildingTuple[0]
        distance = buildingTuple[1]
        cords = buildingObject.cords

        buildName = buildingObject.buildingName
        stationList = buildingObject.stationList
        buildingID = buildingObject.buildingID

        print(buildName, distance, 'ft')

        stationDictList = [] 
        
        for station in stationList:

            stationDict = {}

            stationID = station.stationID
            floor = station.floor 
            status = station.status
            notes = station.notes

            stationDict = {"stationID": stationID, "floor": floor, "status": status, "notes": notes}

            stationDictList.append(stationDict)
        
        lat = cords.lat  
        lon = cords.lon
        buildingDict = {"id": buildingID, "buildingName": buildName, "lat": lat, "lon": lon, "stationList": stationDictList}
        updatedBuildingCount(buildingID)
        allBuildings.append(buildingDict)
    
    finalReturn['places'] = allBuildings

    return json.dumps(finalReturn)

def createReport(lat, lon):
    #Creates the Different Buildings According to CSV: 
    buildingList = IntializeBuildings("Data/building.csv")

    #Appends the Water Stations Into the Building Data Structure: 
    IntializeStations(buildingList, "Data/station.csv")

    cords = Coordinates(lat, lon)
    closestBuilding = nearestBuilding(buildingList, cords)
    return  print5buildings(closestBuilding)


def main():

    updatedBuildingCount(1)

    report = createReport(42.393433, -72.525697)

if __name__ == "__main__":
    main()