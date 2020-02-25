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
    
    //Provides a number for days between date and today
    func numberOfDaysToToday() -> Int {
      return abs(Calendar.current.dateComponents([.day], from: self, to: Date()).day!)
    }
}
