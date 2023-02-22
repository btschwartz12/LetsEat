//
//  MapViewController.swift
//  LetsEat
//
//  Created by Ben Schwartz on 3/23/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = MapDataManager()
    
    var selectedRestaurant: RestaurantItem?
    
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        initialize()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        default:
            print("Segue not added")
        }
    }
}

// MARK: Private Extension
private extension MapViewController {
   
    func initialize() {
        mapView.delegate = self
        if let location = locationManager.location {
            manager.fetch(with: location, hasUserLocation: true) { annotations in addMap(annotations) }
            showAlert(found: true)
        }
        else {
            manager.fetch(with: CLLocation(), hasUserLocation: false) { annotations in addMap(annotations) }
            showAlert(found: false)
        }
    }
    
    func setUpMapView() {
       mapView.showsUserLocation = true
       mapView.showsCompass = true
       mapView.showsScale = true
       currentLocation()
    }
    
    func addMap(_ annotations: [RestaurantItem]) {
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController, let restaurant = selectedRestaurant {
            viewController.selectedRestaurant = restaurant
    }
}
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else { return }
        selectedRestaurant = annotation as? RestaurantItem
        
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        var annotationView: MKAnnotationView?
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
        }
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func currentLocation() {
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       if #available(iOS 11.0, *) {
          locationManager.showsBackgroundLocationIndicator = true
       } else {
          // Fallback on earlier versions
       }
       locationManager.startUpdatingLocation()
    }
    
//    func locationManager(_ locManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       
//       let location = locations.last! as CLLocation
//       manager.userLocation = location.coordinate as CLLocationCoordinate2D
//       locationManager.stopUpdatingLocation()
//    }
    
    func locationManager(_ manager: CLLocationManager,
                        didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager auth status changed to:" )
        switch status {
            case .restricted:
                print("status restricted")
            case .denied:
                print("status denied")

            case .authorized:
                print("status authorized")
                let location = locationManager.location
                print("location: \(String(describing: location))")

            case .notDetermined:
                print("status not yet determined")

            default:
                print("unknown state: \(status)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error.localizedDescription)
    }
    
    func showAlert(found wasFound: Bool) {
        if wasFound {
            let alertController = UIAlertController(title: "Nearest Hotspot Shown", message: "Nearest city with restaurant data to your location is being displayed", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Location not Found", message: "User location not found, display results for Boston by default", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }

}
