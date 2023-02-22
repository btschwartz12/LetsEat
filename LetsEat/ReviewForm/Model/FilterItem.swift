//
//  FilterItem.swift
//  LetsEat
//
//  Created by Ben Schwartz on 4/13/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    
    let filter:String
    let name:String
    
    init(dict:[String:AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
