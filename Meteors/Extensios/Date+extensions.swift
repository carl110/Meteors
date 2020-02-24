//
//  UIDate+extensions.swift
//  Meteors
//
//  Created by Carl Wainwright on 24/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    //Add ammount to a date
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func daysFromToday() -> Int {
      return abs(Calendar.current.dateComponents([.day], from: self, to: Date()).day!)
    }
}
