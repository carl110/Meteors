//
//  MeteorViewModel.swift
//  Meteors
//
//  Created by Carl Wainwright on 24/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class MainViewModel {
    
    //Provide an Int for number of days since the API was last pulled
    func daysSinceLastUpdate() -> Int{
        let fetchedData = CoreDataManager.shared.fetchSavedData()
        var daysSinceUpdate = Int()
        for i in fetchedData! {
            daysSinceUpdate = i.dateOfUpdate.daysFromToday()
            break
        }
        return daysSinceUpdate
    }
}
