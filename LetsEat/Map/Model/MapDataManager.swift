//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Ben Schwartz on 3/23/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation
import MapKit


class MapDataManager: DataManager {
    
    fileprivate var items: [RestaurantItem] = []
    
    //var userLocation: CLLocationCoordinate2D?
    
    var annotations: [RestaurantItem] {
        return items
    }
    
    func fetch(with currentLocation: CLLocation, hasUserLocation hasLoc: Bool, completion: (_ annotations: [RestaurantItem]) -> ()) {
        let manager = RestaurantDataManager()
        let locForRegion = hasLoc ? manager.getNearestToUserLocation(at: currentLocation.coordinate) : "Boston"
        manager.fetch(by: locForRegion) { (items) in
            self.items = items
            completion(items)
        }
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else {
            return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
    
    
}


