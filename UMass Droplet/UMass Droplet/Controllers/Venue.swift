//
//  Venue.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/23/23.
//

import Foundation
import MapKit
import AddressBook
import SwiftyJSON

class Venue : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(title: String, cordinate : CLLocationCoordinate2D){
        self.title = title
        self.coordinate = cordinate
        
        super.init()
    }
    
    class func from(json: JSON) -> Venue? {
        var title: String
        if let unwrappedTitle = json["buildingName"].string {
            title = unwrappedTitle
        }
        else {
            title = ""
        }
        
        let lat = json["lat"].doubleValue
        let lon = json["lon"].doubleValue
        let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        //let stations = json["stationList"].array
        
        return Venue(title: title, cordinate: cordinate)
    }
    
//    func mapItem() -> MKMapItem {
//        let addressDictionary = [String(kABPersonAddressStateKey) : subtitle]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
//        let mapItem = MKMapItem(placemark: placemark)
//        
//        mapItem.name = "\(title)"
//        return mapItem
//    }
}
