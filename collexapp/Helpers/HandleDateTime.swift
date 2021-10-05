//
//  HandleDateTime.swift
//  collexapp
//
//  Created by Lex on 18/5/20.
//  Copyright © 2020 Lex. All rights reserved.
//

import UIKit

class HandleDateTime {
    
    func getTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let result = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
        return result
    }
    
    func getDate() -> String {
        let date = Date()
        let calender = Calendar.current
        let day = calender.component(.day, from: date)
        let month = calender.component(.month, from: date)
        let year = calender.component(.year, from: date)
        let result = String(format: "%02d/%02d/%04d", day, month, year)
        return result
    }
    
    func getDateTime() -> String {
        let date = Date()
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        let second = Calendar.current.component(.second, from: date)
        let result = String(format: "%02d/%02d/%04d %02d:%02d:%02d", day, month, year, hour, minute, second)
        return result
    }
}
