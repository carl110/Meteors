//
//  CustomCollectionView.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit

protocol MeteorCellSelectedDelegate {
    func cellWasSelected(id: String)
    
    func nearingScrollEnd(year: Int)
}

class CustomCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //placeholder for number to remove from year for pagenation
    private var yearCount = 1
    var cellDelegate: MeteorCellSelectedDelegate?
    
    
    override func awakeFromNib() {
        delegate = self
        dataSource = self
        registerCell()
        self.backgroundColor = UIColor.clear
    }
    
    func registerCell() {
        self.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.meteorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        let meteorModel = DataManager.shared.meteorList[indexPath.item]
        cell.populate(meteorModel: meteorModel)
        
        
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meteorModel = DataManager.shared.meteorList[indexPath.item]
        let id = meteorModel.meteorID
        //send id to delegate for ViewController
        cellDelegate?.cellWasSelected(id: id)
    }

    
    //set layout for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if device is iPad then have 2 cells per row - otherwise 1
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            let w = collectionView.frame.size.width
            return CGSize(width: (w / 2 - 5), height: 100)
        } else {
            let w = collectionView.frame.size.width
            return CGSize(width: (w - 20), height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //When scroll gets to 10 before the end
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == DataManager.shared.meteorList.count - 25 {
            //pass number of years to remove to view controller
            cellDelegate?.nearingScrollEnd(year: yearCount)
            yearCount += 1
        }
    }
}
