from IntializeData import *
import json

"""
Given a list of all buildings sorted by how close they are in feet to the cords we provided
"""
def nearestBuilding(buildingList, cords):

    distanceMap = {}

    #Loop over all the buildings on Campus
    for building in buildingList:

        #Take differences between building cords and user cords
        buildingCords = building.cords
        distance = cords.distance(buildingCords)

        #Key is the building Object, Value is the distance
        distanceMap[building] = distance
    
    #Sort the map based on value
    sortedMap = sorted(distanceMap.items(), key=lambda x:x[1])

    return sortedMap
    
"""
Create a JSON list containing all of the Building Information. 
Building Information Includes

BuildingName:
BuildingLat:
BuildingLog: 
StationList:
    StationID:
    Floor:
    Status:
    Notes:

Prints as:
nearestStation.json
"""
def json5buildings(list): 

    allBuildings = []

    #From the sorted Station List take the first Five
    for i in range(0, 5):

        #Grab the current Building Object
        buildingTuple = list[i]
        buildingObject = buildingTuple[0]

        #Grab Attributes of that Object
        distance = buildingTuple[1]
        cords = buildingObject.cords
        buildName = buildingObject.buildingName
        stationList = buildingObject.stationList

        #Prints out the Building alon with the distance
        print(buildName, distance, 'ft')

        #Keep the station List in an array list
        stationDictList = [] 
        
        #Go over all of the Station Lists
        for station in stationList:

            #Station Class is to be converted into a dictonary
            stationDict = {}
            stationID = station.stationID
            floor = station.floor 
            status = station.status
            notes = station.notes
            stationDict = {"stationID": stationID, "floor": floor, "status": status, "notes": notes}

            #Append to the list
            stationDictList.append(stationDict)
        
        #Document the Lat and Lon, append to the Building List
        lat = cords.lat  
        lon = cords.lon
        buildingDict = {"buildingName": buildName, "lat": lat, "lon": lon, "stationList": stationDictList}
        allBuildings.append(buildingDict)
    

    #Ouput the JSON information
    with open("nearestStation.json", "w") as outfile:
        json.dump(allBuildings, outfile, indent=4)



def main():

    #Creates the Different Buildings According to CSV: 
    buildingList = IntializeBuildings("Data/building.csv")

    #Appends the Water Stations Into the Building Data Structure: 
    IntializeStations(buildingList, "Data/station.csv")

    cords = Coordinates(42.38796604784769, -72.529016336402)
    closestBuilding = nearestBuilding(buildingList, cords)
    json5buildings(closestBuilding)

if __name__ == "__main__":
    main()