//
//  MeteorDetailsFactory.swift
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class MeteorDetailsFactory {
    
    static func PushIn(navigationController: UINavigationController, meteorID: String) {
        let storyBoard = UIStoryboard(name: "MeteorDetails", bundle: nil).instantiateInitialViewController() as! MeteorDetailsViewController
        let flowController = MeteorDetailsFlowController(navigationController: navigationController)
        let viewModel = MeteorDetailsViewModel(meteorID: meteorID)
        storyBoard.assignDependancies(flowController: flowController, viewModel: viewModel)
        navigationController.pushViewController(storyBoard, animated: true)
    }
}
