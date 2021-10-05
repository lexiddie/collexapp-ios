//
//  Provider.swift
//  collexapp
//
//  Created by Lex on 19/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//
import UIKit
import ObjectMapper
import Cache

class Provider: Mappable, Codable {
    
    var name: String! = ""
    var email: String! = ""

    init(name: String, email: String) {
        self.name = name
        self.email = email
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
    }
}

