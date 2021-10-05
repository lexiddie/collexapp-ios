//
//  Location.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class GeoPoint: Mappable, Codable {
    
    var lat: Double! = 0.0
    var long: Double! = 0.0

    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        lat <- map["lat"]
        long <- map["long"]
    }
}

