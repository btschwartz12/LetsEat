//
//  FilterManager.swift
//  LetsEat
//
//  Created by Ben Schwartz on 4/13/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    func fetch(completionHandler:(_ items:[FilterItem]) -> Void) {
        var items:[FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
