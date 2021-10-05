//
//  Subcategory.swift
//  collexapp
//
//  Created by Lex on 6/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class Subcategory: Mappable, Codable {
    
    var id: String! = ""
    var name: String! = ""
    var isSelected: Bool = false

    init(id: String, name: String, isSelected: Bool = false) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

