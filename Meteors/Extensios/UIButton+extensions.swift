//
//  UIButton+extensions.swift
//  Meteors
//
//  Created by Carl Wainwright on 21/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func centerTextHorizontally(spacing: CGFloat) {
        //adds spacing/padding to the left and right
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        //centers text
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func buttonSetup() {
        DispatchQueue.main.async { [weak self] in
            self?.backgroundColor = UIColor.Shades.standardGrey.withAlphaComponent(0.6)
            self?.setTitleColor(UIColor.Shades.standardWhite, for: .normal)
            self?.titleLabel?.font = UIFont.boldSystemFont(ofSize: (self?.frame.height)! / 1.2)
            self?.titleLabel?.adjustsFontSizeToFitWidth = true
            self?.centerTextHorizontally(spacing: 8)
            self?.contentVerticalAlignment = .center
            self?.roundCorners(for: .allCorners, cornerRadius: 25)
        }
        
    }
}
