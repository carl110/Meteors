//
//  MeteorDetailsBuilder.swift
//  Meteors
//
//  Created by Carl Wainwright on 25/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class MeteorDetailsBuilder {
    
    static func create() -> UIViewController {
        let navigator = UINavigationController()
        let taskFlow = MeteorDetailsFlow(navigator: navigator)
        let control = UIStoryboard(name: "MeteorDetails", bundle: nil).instantiateInitialViewController() as! MeteorDetailsViewController
        control.assignDependencies(flowController: taskFlow)
        navigator.setViewControllers([control], animated: true)
        return navigator
    }
}
