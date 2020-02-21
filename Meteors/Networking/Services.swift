//
//  Services.swift
//  Meteors
//
//  Created by Carl Wainwright on 20/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class Services {
    
     struct API {
        static let client = SODAClient(domain: "data.nasa.gov", token: "rqpTp3wlTUgrQIV9Cmdl4KLNF")
        static let cellId = "EventSummaryCell"
    }
}
