//
//  UIViewcontroller+extensions.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Set an image as background image to fit entire screen
    func setBackgroundImageStreched() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "meteorShower")
        backgroundImage.contentMode = .scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //custom alert message
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
