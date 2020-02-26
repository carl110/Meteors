//
//  SingletonToPassID.swift
//  Meteors
//
//  Created by Carl Wainwright on 26/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation

class Singleton {
    var id = String()
    class var sharedInstance : Singleton {
        struct Static {
            static let instance : Singleton = Singleton()
        }
        return Static.instance
    }

    var meteorID : String {
        get{
            return self.id
        }

        set {
            self.id = newValue
        }
    }
}
