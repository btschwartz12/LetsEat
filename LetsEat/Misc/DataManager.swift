//
//  DataManager.swift
//  LetsEat
//
//  Created by Ben Schwartz on 3/23/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation

protocol DataManager {
    func load(file name:String) -> [[String:AnyObject]]
}

extension DataManager {
    func load(file name: String) -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"), let items = NSArray(contentsOfFile: path) else {
            return [[:]]
        }
        return items as! [[String:AnyObject]]
    }
}

