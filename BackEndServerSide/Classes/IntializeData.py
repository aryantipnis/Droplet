from classes.Coordinates import *
from classes.WaterStations import *
from classes.Building import * 
import csv
import json

"""
Takes CSV files and will turn them into lists of python classes. 

"""

def IntializeBuildings(file):
    buildingList = []
    with open(file, newline= '') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            buildingID = row[0]
            buildingName = row[1]
            lat = row[2]
            lon = row[3] 
            
            newBuilding = Building(buildingName, 0, lat, lon, buildingID)
            buildingList.append(newBuilding)
    
    return buildingList

"""
Function:
    Will be able to append the water station to the building object. There is a stationList apart of every water station object

Params:
    listOfBuildings: Array containing the buildings object of all buildings on campus
    waterStation: Water Station Object 

Return:
    None

"""
def appendWaterStation(buildingList, waterStation): 
    buildingID = waterStation.buildingID
    buildingObj = buildingList[buildingID]
    stationList = buildingObj.stationList
    stationList.append(waterStation)


"""
Function:
    Will Take a csv file named stationInfo.csv
"""

def IntializeStations(buildingList, file):
    with open(file, newline= '') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            StationID = row[0]
            BuildingID = row[1]
            BuildingName = row[2]
            Floor = row[3]
            Notes = row[4]
            
            newStation = WaterStations(StationID, BuildingID, Floor, Notes)
            appendWaterStation(buildingList, newStation)
    
    return buildingList



            
