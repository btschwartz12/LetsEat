//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Ben Schwartz on 4/3/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation
import MapKit

class RestaurantDataManager {
    
    private var items: [RestaurantItem] = []
    
    func fetch(by location:String, with filter:String = "All", completionHandler:(_ items:[RestaurantItem]) -> Void) {
        
        if let file = Bundle.main.url(forResource: location, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let restaurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if filter != "All" {
                    items = restaurants.filter( { ($0.cuisines.contains(filter)) } )
                }
                else { items = restaurants }
            }
            catch {
                print("there was an error \(error)")
            }
        }
        completionHandler(items)
    }
    
    func getNearestToUserLocation(at currentLocation: CLLocationCoordinate2D) -> String {
        
        var cities: [(name:String, location: CLLocationCoordinate2D)]?
        
        if let files = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "/Users/benschwartz/Desktop/iOS Dev/LetsEat/LetsEat/Misc/JSON") {
            
            for file in files {
                let locationName = file.absoluteString
                let index = locationName.firstIndex(of: ".")
                let city = String(locationName[...index!])
                
                do {
                    let data = try Data(contentsOf: file)
                    let restaurants = try JSONDecoder().decode([RestaurantItem].self, from: data)
                    if let firstCoordinates = restaurants.first?.coordinate {
                        let item = (city, firstCoordinates)
                        cities?.append(item)
                    }
                    else {
                        print("no restaurants found")
                    }
                }
                catch {
                    print("there was an error \(error)")
                }
            }
            if let cityList = cities {
               
                var closestCity:String?
                var smallestDistance: CLLocationDistance?
                let currentLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)

                for city in cityList {
                    let location = CLLocation(latitude: city.location.latitude, longitude: city.location.longitude)
                    let distance = currentLocation.distance(from: location)
                    if smallestDistance == nil || distance < smallestDistance! {
                      closestCity = city.name
                      smallestDistance = distance
                    }
                }
                if let city = closestCity {
                    return city
                }
                else { return "" }
            }
            else { return "" }
        }
        else { print("error reading files"); return "" }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func restaurantItem(at index:IndexPath) -> RestaurantItem {
        return items[index.item]
    }
    
}
