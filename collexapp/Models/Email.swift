//
//  UserEmail.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class Email: Mappable, Codable {
    
    var id: String! = ""
    var verified: Bool! = false

    init(id: String, verified: Bool) {
        self.id = id
        self.verified = verified
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        verified <- map["verified"]
    }
}
