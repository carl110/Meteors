//
//  GetRequest.swift
//  Meteors
//
//  Created by Carl Wainwright on 20/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class GetRequest {
    
    let services = Services()
    
    static func getMeteorList (_ sender: Any, completion: @escaping (Bool, [MeteorModel]?) -> Void) {
        
        var meteorData: [[String: Any]]! = []
        var list = [MeteorModel]()
        let today = Date()
        
        //Make a query with a filter to pull all dataes from 2011 onwards
        let query = Services.API.client.query(dataset: "gh4g-9sfh").filter("year >= '2011'")
        
        //Order query result by mass
        query.orderDescending("mass").get { response in
            switch response {
            case .dataset (let data):
                
                //Remove any previosuly saved data - stop duplicates
                CoreDataManager.shared.deleteAllSavedData()

                // Update data
                meteorData = data
                //Save data to coreData
                for meteors in meteorData {
                    guard let meteorID = meteors["id"] as? String,
                        let meteorSize = meteors["mass"] as? String,
                        let name = meteors["name"] as? String,
                        let year = meteors["year"] as? String,
                        let long = meteors["reclong"] as? String,
                        let lat = meteors["reclat"] as? String else {
                            print ("unable to get data")
                            return
                    }
                    
                    //Set mass as 0 when no data is available
                    let number = Int32(meteorSize) ?? 0
                    
                    if number > 0 {
                        let meteorModel = MeteorModel(meteorID: meteorID, meteorSize: number, name: name, year: year, longitude: long, latitude: lat)
                        
                        list.append(meteorModel)
                        CoreDataManager.shared.saveMeteorData(meteorID: meteorID,
                                                              meteorSize: number,
                                                              name: name,
                                                              year: year,
                                                              longitude: long,
                                                              latitude: lat,
                                                              dateOfUpdate: today)
                    }
                }
                
                completion(true, list)
                
            case .error (let err):
                let errorMessage = (err as NSError).userInfo.debugDescription
                print (errorMessage)
                
            }
        }
    }
}
