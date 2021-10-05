//
//  ListProduct.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class ListProduct: Mappable, Codable {
    
    var id: String! = ""
    var productImageUrl: String! = ""
    var sellerId: String! = ""
    var sellerImageUrl: String! = ""
    var name: String! = ""
    var price: Double! = 0.0
    var currency: String! = ""
    var condition: String! = ""
    var category: String! = ""
    var geoPoint: GeoPoint!
    var isSold: Bool! = false

    init(id: String, productImageUrl: String, sellerId: String, sellerImageUrl: String!, name: String, price: Double, currency: String, condition: String, category: String, location: GeoPoint, isSold: Bool = false) {
        self.id = id
        self.productImageUrl = productImageUrl
        self.sellerId = sellerId
        self.sellerImageUrl = sellerImageUrl
        self.name = name
        self.price = price
        self.currency = currency
        self.condition = condition
        self.category = category
        self.geoPoint = location
        self.isSold = isSold
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        productImageUrl <- map["productImageUrl"]
        sellerId <- map["sellerId"]
        sellerImageUrl <- map["sellerImageUrl"]
        name <- map["name"]
        price <- map["price"]
        currency <- map["currency"]
        condition <- map["condition"]
        category <- map["category"]
        geoPoint <- map["location"]
        isSold <- map["isSold"]
    }
}

