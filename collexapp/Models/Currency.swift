//
//  Currency.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class Currency: Mappable, Codable {
    
    var name: String! = ""
    var code: String! = ""

    init() { }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        code <- map["code"]
    }
}
