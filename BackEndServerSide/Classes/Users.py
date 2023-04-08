from Coordinates import *

class Users:
    def __init__(self, uid, username, waterConsumed):
        self.uid = uid
        self.username = username
        self.waterConsumed = int(waterConsumed)