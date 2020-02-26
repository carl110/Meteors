//
//  ColourTests.swift
//  MeteorsTests
//
//  Created by Carl Wainwright on 24/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import XCTest
@testable import Meteors

class ColourTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    func testHexConversiontoUIColor() {
        
        XCTAssertEqual(UIColor.Shades.standardWhite, UIColor(red: 1, green: 1, blue: 1, alpha: 1), "This colour should be white")
        XCTAssertEqual(UIColor.Shades.standardBlack, UIColor(red: 0, green: 0, blue: 0, alpha: 1), "This colour should be black")
        XCTAssertEqual(UIColor.Reds.standardRed, UIColor(red: 1, green: 0, blue: 0, alpha: 1), "This colour should be red")
        XCTAssertEqual(UIColor.Greens.standardGreen , UIColor(red: 0, green: 1, blue: 0, alpha: 1), "This colour should be green")
        XCTAssertEqual(UIColor.Blues.standardBlue, UIColor(red: 0, green: 0, blue: 1, alpha: 1), "This colour should be blue")
    }

}
