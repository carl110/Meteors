//
//  DataForMeteors.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import CoreData

class DataForMeteors {
    
    var meteorID: String
    var meteorSize: Int32
    var name: String
    var year: String
    var longitude: String
    var latitude: String
    
    
    init(object: NSManagedObject) {
        self.meteorID = object.value(forKey: "meteorID") as! String
        self.meteorSize = object.value(forKey: "meteorSize") as! Int32
        self.name = object.value(forKey: "name") as! String
        self.year = object.value(forKey: "year") as! String
        self.longitude = object.value(forKey: "longitude") as! String
        self.latitude = object.value(forKey: "latitude") as! String
    }
    
}
