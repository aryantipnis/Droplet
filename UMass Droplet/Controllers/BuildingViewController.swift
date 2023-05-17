//
//  BuildingViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/11/23.
//

import Foundation
import UIKit
import SwiftyJSON
import SwiftUI
import CoreLocation
import MapKit

class BuildingViewController: UIViewController {

    var venue = AccountManager.shared.venue
    var stationList: [Station] = []
    
   
    @IBOutlet weak var theContainer: UIView!
    @IBAction func navigateTapped(_ sender: Any) {
        
        if let venue = AccountManager.shared.venue {
            let destination = CLLocationCoordinate2D(latitude: venue.coordinate.latitude, longitude: venue.coordinate.longitude)
            let placemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = venue.title
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
            mapItem.openInMaps(launchOptions: options)
        }
        else {
            print("Venue is nil")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: WaterStationsUIView(venue: AccountManager.shared.venue))
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
      }
        
}
    
