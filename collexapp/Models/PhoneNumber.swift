//
//  PhoneNumber.swift
//  collexapp
//
//  Created by Lex on 21/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class PhoneNumber: Mappable, Codable {
    
    var number: String! = ""
    var country: String! = ""
    var verified: Bool! = false

    init(number: String = "", country: String = "", verified: Bool = false) {
        self.number = number
        self.country = country
        self.verified = verified
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        number <- map["number"]
        country <- map["country"]
        verified <- map["verified"]
    }
}
