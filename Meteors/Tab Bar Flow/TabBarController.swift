//
//  TabBarController.swift
//  Meteors
//
//  Created by Carl Wainwright on 25/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var tbFlow: TabBarFlow!
    
    func assignDependencies(tbFlow: TabBarFlow) {
        self.tbFlow = tbFlow
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //Load view for rendering ease
        self.selectedIndex = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        //select initial VC to show
        self.selectedIndex = 0
    }
    
    //When changing tab page, call annimation.
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabPageAnnimator()
    }
}
