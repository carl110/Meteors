//
//  CustomCollectionViewCell.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var meteorLabel: UILabel!
    @IBOutlet weak var meteorImage: UIImageView!
    
    var sizeOfMeteor: Int32?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.contentView.backgroundColor = UIColor.clear
//        backgroundView?.backgroundColor = UIColor.clear
        
        meteorLabel.backgroundColor = UIColor.Shades.standardGrey.withAlphaComponent(0.6)
//        meteorLabel.backgroundColor?.withAlphaComponent(0.2)
//        meteorLabel.alpha = 0.8
        meteorLabel.numberOfLines = 0
        meteorLabel.textAlignment = .center
        meteorLabel.font = UIFont.boldSystemFont(ofSize: self.bounds.height / 4)
        meteorLabel.adjustsFontSizeToFitWidth = true
        meteorLabel.textColor = UIColor.Shades.standardWhite
        meteorLabel.layer.borderWidth = 4
        meteorLabel.layer.borderColor  = UIColor.Yellows.mustardYellow.cgColor
//        meteorLabel.layer.borderColor = .red
    }
    
    func populate(meteorModel: MeteorModel) {
        meteorLabel.text = "\(meteorModel.name)\n\(meteorModel.meteorSize) grams"
        meteorImage.image = UIImage(named: "chevron")
        meteorLabel.font = UIFont.boldSystemFont(ofSize: self.bounds.height / 4)
        meteorLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    override func prepareForReuse() {
        // Maybe use
    }

}
