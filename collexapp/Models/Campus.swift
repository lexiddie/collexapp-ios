//
//  Campus.swift
//  collexapp
//
//  Created by Lex on 2/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class Campus: Mappable, Codable {
    
    var name: String! = ""
    var geoPoint: GeoPoint!

    init() { }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        geoPoint <- map["location"]
    }
}
