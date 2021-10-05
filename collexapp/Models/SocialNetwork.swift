//
//  Social.swift
//  collexapp
//
//  Created by Lex on 21/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class SocialNetwork: Mappable, Codable {
    
    var name: String! = ""
    var username: String! = ""

    init(name: String = "Messenger", username: String) {
        self.name = name
        self.username = username
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        username <- map["username"]
    }
}

