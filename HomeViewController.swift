//
//  HomeViewController.swift
//  UMass Droplet
//
//  Created by Aryan Tipnis  on 4/7/23.
//
import MapKit
import UIKit
import CoreLocation
import Foundation
import SwiftyJSON

public class HomeViewController: UIViewController, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    var stationManager = JSONDecoder()
    var venues = [Venue]() // Initialize an empty array
    
    @IBOutlet weak var zoomIn: UIButton!
    @IBOutlet weak var zoomOut: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    private var refreshButton: UIBarButtonItem!
    
    public override func viewDidLoad() {
            super.viewDidLoad()
            
            self.overrideUserInterfaceStyle = .dark
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        
            var coordinate: CLLocationCoordinate2D
            
            if let userLocation = locationManager.location?.coordinate {
                coordinate = userLocation
            } else {
                // Default fallback location
                coordinate = CLLocationCoordinate2D(latitude: 42.389705, longitude: -72.528542)
            }
        
            mapView.showsUserLocation = true
            mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)), animated: true)
            mapView.showsScale = true
            mapView.showsCompass = true
            mapView.delegate = self
            
            Task {
                do {
                    venues = try await stationManager.fetchData(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    mapView.addAnnotations(venues)
                } catch {
                    print("Error fetching venues: \(error)")
                }
            }
        
            refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonAction))
            refreshButton.tintColor = .white
            navigationItem.leftBarButtonItem = refreshButton
        }
        
    
  //Filter Locations
  //let filterLocations = [["title": "Bartlett Hall", "latitude": 42.3879676 , "longitude": -72.5286741], ["title": "Herter Hall", "latitude": 42.3877501 , "longitude": -72.5273012], ["title": "Curry Hicks Cage", "latitude": 42.3869766 , "longitude": -72.528243], ["title": "Memorial Hall", "latitude": 42.3883837 , "longitude": -72.5275768], ["title": "Old Chapel", "latitude": 42.389087 , "longitude": -72.527924]]
  //Create Markers
    
  func createAnnotations(locations : [[String : Any]]){
    for location in locations {
      let annotations = MKPointAnnotation()
      annotations.title = location["title"] as? String
      annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
      mapView.addAnnotation(annotations)
    }
  }
  @IBAction func zoomInTapped(_ sender: Any) {
    var span = mapView.region.span
    span.latitudeDelta = max(span.latitudeDelta / 2, 0.001)
    span.longitudeDelta = max(span.longitudeDelta / 2, 0.001)
    let region = MKCoordinateRegion(center: mapView.region.center, span: span)
    mapView.setRegion(region, animated: true)
  }
  @IBAction func zoomOutTapped(_ sender: Any) {
    var span = mapView.region.span
      span.latitudeDelta = max(span.latitudeDelta * 2, 0.001)
      span.longitudeDelta = max(span.longitudeDelta * 2, 0.001)
      let region = MKCoordinateRegion(center: mapView.region.center, span: span)
      mapView.setRegion(region, animated: true)
  }
}
extension HomeViewController {
  public func mapView(_ mapView: MKMapView, viewFor annotation : MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? Venue {
      let identifier = "pin"
      var view: MKMarkerAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      }
      else {
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
      }
      return view
    }
    return nil
  }
  public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
      guard let venue = view.annotation as? Venue else { return }
      AccountManager.shared.venue = venue
      
      let story = UIStoryboard(name: "Main", bundle: nil)
      let controller = story.instantiateViewController(withIdentifier: "BuildingViewController")
      controller.modalPresentationStyle = .fullScreen
      self.present(controller, animated: true)
  }
    
    
    @objc func refreshButtonAction() {
            // Perform the refresh action here
        
        Task {
                do {
                    mapView.removeAnnotations(mapView.annotations)
                    guard let userCoordinate = mapView.userLocation.location?.coordinate else {
                        print("Error: User location not available")
                        return
                    }
                    
                    venues = try await stationManager.fetchData(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
                    mapView.addAnnotations(venues)
                } catch {
                    print("Error fetching venues: \(error)")
                }
            }
        }
    
}
