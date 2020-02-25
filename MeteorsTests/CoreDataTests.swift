//
//  CoreDataTests.swift
//  MeteorsTests
//
//  Created by Carl Wainwright on 24/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import XCTest
import CoreData

@testable import Meteors

class CoreDataTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!

    override func setUp() {
        coreDataManager = CoreDataManager.shared
        
        //remove all data to allow a clean test
        coreDataManager.deleteAllSavedData()
    }
    
    //Test CoreData instance exists
    func initCoreDataManager() {
        let instance = CoreDataManager.shared
        XCTAssertNotNil (instance)
    }

    //Tests data is being saved
    func saveMeteorData() {
        let meteorID = "M1ID"
        let meteorSize: Int32 = 6000
        let name = "MeteorName"
        let year = "2020"
        let longitude = "-77.0098"
        let latitude = "38.8765"
        let dateOfUpdate = Date()
        
        let meteor1: () = coreDataManager.saveMeteorData(meteorID: meteorID, meteorSize: meteorSize, name: name, year: year, longitude: longitude, latitude: latitude, dateOfUpdate: dateOfUpdate)
        
        XCTAssertNotNil(meteor1)
    }
    
    //Tests saved data equals the input
    func fetchMeteorList() {
        let results = coreDataManager.fetchSavedData()
        
        XCTAssertEqual(results?.count, 1)
    }
    
    //Test that all data is deleetd from table
    func deleteEntireTable() {
        coreDataManager.deleteAllSavedData()
        let results = coreDataManager.fetchSavedData()
        
        XCTAssertEqual(results?.count, 0)
    }
    
    //Tests are run alphabetically, so to get the test to run in the correct order the below function is used
    func testRunInOrder() {
        initCoreDataManager()
        saveMeteorData()
        fetchMeteorList()
        deleteEntireTable()
    }

}
