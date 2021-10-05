//
//  UniversityDto.swift
//  collexapp
//
//  Created by Lex on 2/9/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit
import ObjectMapper
import Cache

class UniversityDto: Mappable, Codable {
    
    var name: String! = ""
    var abbreviation: String! = ""
    var campuses: [Campus] = []
    
    init() { }

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        abbreviation <- map["abbreviation"]
        campuses <- map["campuses"]
    }
    
    func getCampus(index: Int) -> String {
        return "\(String(name)) | \(String(campuses[index].name))"
    }
    
    func getUniversity(index: Int) -> University {
        return University(name: self.name, abbreviation: self.abbreviation, campus: self.campuses[index].name)
    }
}
