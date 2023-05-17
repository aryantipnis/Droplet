from classes.Coordinates import * 

class WaterStations:
    def __init__(self, stationID, buildingID, floor, notes):
        self.buildingID = int(buildingID)
        self.floor = int(floor)
        self.status = "good" 
        self.stationID = int(stationID)
        self.notes = str(notes)