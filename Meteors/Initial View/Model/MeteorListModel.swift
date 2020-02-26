//
//  MeteorModel.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class MeteorListModel {
    
    var meteorID: String
    var meteorSize: Int32
    var name: String
    var year: String
    var longitude: String
    var latitude: String
    
    
    init(meteorID: String, meteorSize: Int32, name: String, year: String, longitude: String, latitude: String) {
        self.meteorID = meteorID
        self.meteorSize = meteorSize
        self.name = name
        self.year = year
        self.longitude = longitude
        self.latitude = latitude
    }
}
