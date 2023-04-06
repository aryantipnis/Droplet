from Coordinates import *

class Users:
    def __init__(self, lat, lon, waterConsumed):
        self.cords = Coordinates(lat, lon)
        self.waterConsumed = waterConsumed