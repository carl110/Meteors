//
//  TabPageAnnimator.swift
//  Meteors
//
//  Created by Carl Wainwright on 26/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

class TabPageAnnimator: NSObject, UIViewControllerAnimatedTransitioning {

    //Perform annimation
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        destination.transform = .init(scaleX: 0.1, y: 0.1)
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }

    //Durration of annimation
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

}
