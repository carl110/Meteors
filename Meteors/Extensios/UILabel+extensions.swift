//
//  UILabel+extensions.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func titleLabelSetUp(text: String) {
        self.text = text
        self.textColor = UIColor.Shades.standardWhite
        self.textAlignment = .center
        self.numberOfLines = 0
        self.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.font = self.font.bold()
    }

    func meteorDataLabelSetup() {
         self.backgroundColor = UIColor.clear
         self.numberOfLines = 5
         self.textAlignment = .left
         self.font = UIFont.boldSystemFont(ofSize: self.bounds.height / 12)
         self.adjustsFontSizeToFitWidth = true
         self.textColor = UIColor.Shades.standardWhite
         self.layer.borderWidth = 4
         self.layer.borderColor  = UIColor.Yellows.mustardYellow.cgColor
    }
}
