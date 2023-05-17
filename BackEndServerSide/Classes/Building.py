from classes.Coordinates import *
from classes.WaterStations import *

class Building:
    def __init__(self, buildingName, totalFloors, lat, lon, buildingID):
        self.buildingName = buildingName
        self.totalFloors = int(totalFloors)
        self.cords = Coordinates(lat, lon)
        self.buildingID = int(buildingID)
        self.stationList = []

    def appendStation(self, waterStation):
        self.stationList.append(waterStation)