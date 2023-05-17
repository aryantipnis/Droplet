import Foundation
import MapKit
import AddressBook
import SwiftyJSON
class Venue : NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let stationList: [Station]
  init(title: String, cordinate : CLLocationCoordinate2D, stationList: [Station]){
    self.title = title
    self.coordinate = cordinate
    self.stationList = stationList
    super.init()
  }
  class func from(json: JSON) -> Venue? {
    guard let lat = json["lat"].double, let lon = json["lon"].double else {
          return nil
    }
    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    guard let title = json["buildingName"].string else { return nil}
    let stationListJSON = json["stationList"].array ?? []
    var stationList: [Station] = []
    for stationJSON in stationListJSON {
      if let station = Station.from(json: stationJSON) {
        stationList.append(station)
      }
    }
    return Venue(title: title, cordinate: coordinate, stationList: stationList)
  }
}
struct Station {
  let stationID: Int?
  let floor: Int?
  let status: String?
  let notes: String?
  static func from(json: JSON) -> Station? {
    guard let stationID = json["stationID"].int, let floor = json["floor"].int else {
      return nil
    }
    let status = json["status"].string
    let notes = json["notes"].string
    return Station(stationID: stationID, floor: floor, status: status, notes: notes)
  }
}
