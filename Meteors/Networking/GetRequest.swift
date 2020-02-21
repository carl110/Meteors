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
        
       static func getMeteorListm (_ sender: Any) {
        
        var meteorData: [[String: Any]]! = []
            
        //Make a query with a filter to pull all dataes from 2011 onwards
        let query = Services.API.client.query(dataset: "gh4g-9sfh").filter("year >= '2011'")
            
            //Order query result by mass
            query.orderDescending("mass").get { response in
                switch response {
                case .dataset (let data):
                    // Update data
                    meteorData = data
                case .error (let err):
                    let errorMessage = (err as NSError).userInfo.debugDescription
                    print (errorMessage)
                }
                
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
                    

                    
                    
                    
                    let number = Int32(meteorSize) ?? 0
                    
                                        let meteorModel = MeteorModel(meteorID: meteorID, meteorSize: number, name: name, year: year, longitude: long, latitude: lat)
                    
                    print (meteorModel.name)
                    
                    CoreDataManager.shared.saveMeteorData(meteorID: meteorID,
                                                          meteorSize: number,
                                                          name: name,
                                                          year: year,
                                                          longitude: long,
                                                          latitude: lat)
                    
                }
                            // Update the UI
//                self.meteorCollectionView.refreshControl?.endRefreshing()
    //                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //                        self.tableView.reloadData()
    //                        self.updateMap(animated: true)
            }
        }
    
        static func getMeteorList (_ sender: Any, completion: @escaping (Bool, [MeteorModel]?) -> Void) {
            
            var meteorData: [[String: Any]]! = []
            var list = [MeteorModel]()
                
            //Make a query with a filter to pull all dataes from 2011 onwards
            let query = Services.API.client.query(dataset: "gh4g-9sfh").filter("year >= '2011'")
                
                //Order query result by mass
                query.orderDescending("mass").get { response in
                    switch response {
                    case .dataset (let data):
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
                            
//                            print (meteorModel.name)
                            
                            CoreDataManager.shared.saveMeteorData(meteorID: meteorID,
                                                                  meteorSize: number,
                                                                  name: name,
                                                                  year: year,
                                                                  longitude: long,
                                                                  latitude: lat)
                            }
                        }
                        
                        completion(true, list)
                        
                    case .error (let err):
                        let errorMessage = (err as NSError).userInfo.debugDescription
                        print (errorMessage)
                        
                    }
                }
            }
          static func getMeteorLists (_ sender: Any, completion: @escaping (Bool, [MeteorModel]?) -> Void) {
            
            print ("get meteorlists")
            
            var meteorData: [[String: Any]]! = []
                
            //Make a query with a filter to pull all dataes from 2011 onwards
            let query = Services.API.client.query(dataset: "gh4g-9sfh").filter("year >= '2011'")
                
                //Order query result by mass
                query.orderDescending("mass").get { response in
                    switch response {
                    case .dataset (let data):
                        
                        print ("case 1")
                        // Update data
                        meteorData = data
                        
                        var list = [MeteorModel]()
                        
                        //Save data to coreData
                        for meteors in meteorData {
                            if let meteorID = meteors["id"] as? String,
                                let meteorSize = meteors["mass"] as? Int32,
                                let name = meteors["name"] as? String,
                                let year = meteors["year"] as? String,
                                let long = meteors["reclong"] as? String,
                                let lat = meteors["reclat"] as? String {
                                let meteorModel = MeteorModel(meteorID: meteorID, meteorSize: meteorSize, name: name, year: year, longitude: long, latitude: lat)
                                
                                print (meteorID)
                              
                                list.append(meteorModel)
                            }
                        }
                        
                        completion (true, list)

                    case .error (let err):
                        let errorMessage = (err as NSError).userInfo.debugDescription
                        print (errorMessage)
                    }
                    
                    var list = [MeteorModel]()
                    
                    //Save data to coreData
                    for meteors in meteorData {
                        if let meteorID = meteors["id"] as? String,
                            let meteorSize = meteors["mass"] as? Int32,
                            let name = meteors["name"] as? String,
                            let year = meteors["year"] as? String,
                            let long = meteors["reclong"] as? String,
                            let lat = meteors["reclat"] as? String {
                            let meteorModel = MeteorModel(meteorID: meteorID, meteorSize: meteorSize, name: name, year: year, longitude: long, latitude: lat)
                            print ("unable to get data")
                            
                            //                            CoreDataManager.shared.saveMeteorData(meteorID: meteorID,
                            //                                                                                         meteorSize: meteorSize,
                            //                                                                                         name: name,
                            //                                                                                         year: year,
                            //                                                                                         longitude: long,
                            //                                                                                         latitude: lat)
                            list.append(meteorModel)
                        }
                    }
                    completion(true, list)
            }
            
    }
    
//        static func getFilmList(term: String, completion: @escaping (Bool, [FilmModel]?) -> Void) {
//            let session = URLSession(configuration: .default)
//            let request = RequestBuilder.createSearchRequest(term: term)
//            let task = session.dataTask(with: request) { (data, response, error) in
//                if let data = data, error == nil {
//                    if let response = response as? HTTPURLResponse, response.statusCode == 200,
//                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                        let results = responseJSON["results"] as? [AnyObject] {
//                        var list = [FilmModel]()
//                        for i in 0 ..< results.count {
//                            guard let film = results[i] as? [String: Any] else {
//                                continue
//                            }
//                            if let id = film["trackId"] as? Int,
//                                let title = film["trackName"] as? String,
//                                let catagory = film["primaryGenreName"] as? String,
//                                let yearOfRelease = film["releaseDate"] as? String,
//                                let artworkURL = film["artworkUrl100"] as? String {
//                                let filmModel = FilmModel(id: id, title: title, catagory: catagory, yearOfRelease: yearOfRelease, artworkURL: artworkURL)
//
//    //                            print (filmModel.title)
//                                list.append(filmModel)
//                            }
//                        }
//
//                        completion(true, list)
//                    }
//                    else {
//                        completion(false, nil)
//                    }
//                } else {
//                    completion(false, nil)
//                }
//            }
//            task.resume()
//        }
}
