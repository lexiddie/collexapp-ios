//
//  University.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class University: Mappable, Codable {
    
    var name: String! = ""
    var abbreviation: String! = ""
    var campus: String! = ""
    
    init(name: String, abbreviation: String, campus: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.campus = campus
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        abbreviation <- map["abbreviation"]
        campus <- map["campus"]
    }
}
