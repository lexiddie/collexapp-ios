//
//  CreateProduct.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class Product: Mappable, Codable {
    
    var id: String! = ""
    var sellerId: String! = ""
    var university: University!
    var currency: Currency!
    var name: String! = ""
    var price: Double! = 0.0
    var condition: String! = ""
    var category: String! = ""
    var description: String! = ""
    var geoPoint: GeoPoint!
    var photoUrls: [String] = []
    var isSold: Bool! = false

    init(id: String, sellerId: String, university: University, currency: Currency, name: String, price: Double, condition: String, category: String, description: String, geoPoint: GeoPoint, photoUrls: [String]) {
        self.id = id
        self.sellerId = sellerId
        self.university = university
        self.currency = currency
        self.name = name
        self.price = price
        self.condition = condition
        self.category = category
        self.description = description
        self.geoPoint = geoPoint
        self.photoUrls = photoUrls
        self.isSold = false
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        sellerId <- map["sellerId"]
        university <- map["university"]
        currency <- map["currency"]
        name <- map["name"]
        price <- map["price"]
        condition <- map["condition"]
        category <- map["category"]
        description <- map["description"]
        geoPoint <- map["location"]
        photoUrls <- map["photoUrls"]
        isSold <- map["isSold"]
    }
}

