//
//  UIFont+extensions.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    //Allows traits such as bold to be added to text without changing the size or font
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func bold() -> UIFont {
        return with(.traitBold)
    }
    
    func italic() -> UIFont {
        return with(.traitItalic)
    }
}
