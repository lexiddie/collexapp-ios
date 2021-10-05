//
//  User.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//
import UIKit
import ObjectMapper
import Cache

class User: Mappable, Codable {
    
    var id: String! = ""
    var fullName: String! = ""
    var username: String! = ""
    var profileUrl: String! = ""
    var password: String! = ""
    var phoneNumber: PhoneNumber!
    var socialNetworks: [SocialNetwork] = []
    var provider: Provider!
    var email: Email!
    var university: University!
    var currency: Currency!
    var createdDateTime: String! = ""

    init(fullName: String, username: String, password: String, provider: Provider, email: Email) {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.provider = provider
        self.email = email
        self.phoneNumber = PhoneNumber()
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["fullName"]
        username <- map["username"]
        profileUrl <- map["profileUrl"]
        password <- map["password"]
        phoneNumber <- map["phoneNumber"]
        socialNetworks <- map["socialNetworks"]
        email <- map["email"]
        university <- map["university"]
        currency <- map["currency"]
        createdDateTime <- map["createdDateTime"]
    }
}
