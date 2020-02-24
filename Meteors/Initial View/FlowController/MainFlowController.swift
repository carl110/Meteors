//
//  MainFlowController.swift
//
//  Created by Carl Wainwright on 20/12/2019.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MainFlowController {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //Factory of view to show
    func showMeteorDetails(meteorID: String) {
            MeteorDetailsFactory.PushIn(navigationController: navigationController, meteorID: meteorID)
        }
}
