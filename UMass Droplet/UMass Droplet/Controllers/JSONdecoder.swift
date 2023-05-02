//
//  JSONdecoder.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/25/23.
//

import Foundation
import SwiftyJSON

public class JSONdecoder {
    
    @Published var venues = [Venue]()
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        let fileName = Bundle.main.path(forResource: "test", ofType: "json")
        let filePath = URL(fileURLWithPath: fileName!)
        var data: Data?
        do {
            data = try Data(contentsOf: filePath, options: Data.ReadingOptions(rawValue: 0))
        }
        catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            let json = try? JSON(data: jsonData)
            if let venueJSONs = json?["places"].array {
                for venueJSON in venueJSONs {
                    if let venue = Venue.from(json: venueJSON) {
                        self.venues.append(venue)
                    }
                }
            }
        }
    }
    
}
