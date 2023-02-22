//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Ben Schwartz on 3/21/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation

class LocationDataManager {
    
    private var locations: [LocationItem] = []
    
    func fetch() {
        for location in loadData() {
            locations.append(LocationItem(dict: location))
        }
    }

    func numberOfItems() -> Int {
        return locations.count
    }
    
    func locationItem(at index: IndexPath) -> LocationItem {
        return locations[index.item]
    }
    
    private func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        return items as! [[String:AnyObject]]
    }
    func findLocation(_ name: String) -> (isFound:Bool, position:Int) {
        guard let index = locations.firstIndex(where: { $0.city == name } )
            else {
                return (isFound:false, position:0)
            }
        return (isFound: true, position: index)
    }
}
