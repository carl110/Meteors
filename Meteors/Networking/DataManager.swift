//
//  DataManager.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    lazy var meteorList: [MeteorListModel] = {
        
        var list = [MeteorListModel]()
        
        let meteor = MeteorListModel(meteorID: "No meteors to show",
                                 meteorSize: 1,
                                 name: "Please wait while data loads",
                                 year: "Year",
                                 longitude: "long",
                                 latitude: "lat")
        list.append(meteor)
        
        return list
    } ()
}
