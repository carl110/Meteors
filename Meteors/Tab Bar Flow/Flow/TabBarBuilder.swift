//
//  TabBarBuilder.swift
//  Meteors
//
//  Created by Carl Wainwright on 25/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarBuilder {
    
    struct TabIndex {
        static let MeteorList = 0
        static let MeteorDetails = 1
    }
    
    static func showIn(window: UIWindow) {
        
        let tbController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TabBarController
        let tbFlow = TabBarFlow(tbController: tbController)
        
        tbController.viewControllers = setupTabControllers(tbFlow: tbFlow)
        tbController.assignDependencies(tbFlow: tbFlow)
        tbController.tabBar.isHidden = true
        
        window.rootViewController = tbController
    }
    
    private static func setupTabControllers(tbFlow: TabBarFlow) -> [UIViewController] {
        
        let meteorListVC = tbFlow.getMeteorListViewController()
        
        let meteorDetailsVC = tbFlow.getMapViewViewController()

        let viewControllerList = [meteorListVC, meteorDetailsVC]
        
        return viewControllerList
    }
}
