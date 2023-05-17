import geopy.distance


class Coordinates:
    def __init__(self, latitude, longitdue):
        self.lat = float(latitude)
        self.lon = float(longitdue)

    #Takes two coordinates and returns the distances between the two
    def distance(self, cord2):
        lat1 = self.lat
        lat2 = cord2.lat

        lon1 = self.lon
        lon2 = cord2.lon

        cordSet1 = (lat1, lon1)
        cordSet2 = (lat2, lon2)

        return geopy.distance.geodesic(cordSet1, cordSet2).ft


