//
//  JSONdecoder.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/25/23.
//

import Foundation
import SwiftyJSON
import CoreLocation

public class JSONDecoder {
    @Published var venues = [Venue]()
    
    func fetchData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> [Venue] {
        let url = URL(string: "https://flask-api-amber.vercel.app/cords=\(latitude),\(longitude)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let json = try JSON(data: data)
        if let venueJSONs = json["places"].array {
            for venueJSON in venueJSONs {
                if let venue = Venue.from(json: venueJSON) {
                    self.venues.append(venue)
                }
            }
        }
        return venues
    }
}
    


