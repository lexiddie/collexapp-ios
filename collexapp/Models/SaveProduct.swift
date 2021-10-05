//
//  SaveProduct.swift
//  collexapp
//
//  Created by Lex on 24/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class SaveProduct: Mappable, Codable {
    
    var id: String! = ""
    var productId: String! = ""
    var userId: String! = ""

    init(id: String, productId: String, userId: String) {
        self.id = id
        self.productId = productId
        self.userId = userId
    }

    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        productId <- map["productId"]
        userId <- map["userId"]
    }
}

