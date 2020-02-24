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
    
    func initCoreDataManager() {
        let instance = CoreDataManager.shared
        XCTAssertNotNil (instance)
    }



}
