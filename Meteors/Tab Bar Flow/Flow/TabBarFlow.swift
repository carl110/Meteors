//
//  TabBarFlow.swift
//  Meteors
//
//  Created by Carl Wainwright on 25/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarFlow: NSObject {
    
    fileprivate let tbController: UITabBarController
    
    init(tbController: UITabBarController) {
        self.tbController = tbController
    }

    func getMeteorListViewController() -> UIViewController {
        return MeteorListBuilder.create()
    }
    
    func getMapViewViewController() -> UIViewController {
        return MeteorDetailsBuilder.create()
    }
    
}
