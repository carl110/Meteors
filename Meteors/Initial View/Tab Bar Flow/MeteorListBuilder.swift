//
//  MeteorListBuilder.swift
//  Meteors
//
//  Created by Carl Wainwright on 25/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MeteorListBuilder {
    static func create() -> UIViewController {

        let navigator = UINavigationController()
        let taskFlow = MeteorListFlow(navigator: navigator)
        let control = UIStoryboard(name: "MeteorList", bundle: nil).instantiateInitialViewController() as! MeteorListViewController
        control.assignDependencies(flowController: taskFlow)
        navigator.setViewControllers([control], animated: true)
        return navigator
    }
}
