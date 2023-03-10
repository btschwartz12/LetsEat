//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Ben Schwartz on 4/17/20.
//  Copyright © 2020 Ben Schwartz. All rights reserved.
//

import UIKit
struct ReviewItem {
    var rating:Float?
    var name:String?
    var title:String?
    var customerReview:String?
    var date:Date?
    var restaurantID:Int?
    var uuid = UUID().uuidString
    
    var displayDate:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        guard let reviewDate = date else { return "" }
        return formatter.string(from: reviewDate as Date)
    }
}

extension ReviewItem {
    init(data:Review) {
        if let reviewDate = data.date { self.date = reviewDate }
        self.customerReview = data.customerReview
        self.name = data.name
        self.title  = data.title
        self.restaurantID = Int(data.restaurantID)
        self.rating = data.rating
        if let uuid = data.uuid { self.uuid = uuid }
    }
}
