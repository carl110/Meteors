//
//  ViewController.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, MeteorCellSelectedDelegate {
    
    fileprivate var mainFlowController: MainFlowController!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var meteorCollectionView: CustomCollectionView!
    
    func assignDependancies(mainFlowController: MainFlowController) {
        self.mainFlowController = mainFlowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.deleteAllSavedData()
        
        initialSetup()

        collectionViewSetup()

    }
    
    func initialSetup() {
        
        setBackgroundImageStreched()
         titleLabel.titleLabelSetUp(text: "Pick A Meteor")
        meteorCollectionView.cellDelegate = self
        
        //set layout of collectionview cells
        let layout = UICollectionViewFlowLayout()
        self.meteorCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func cellWasSelected(id: String) {
        print ("cell pressedx with id\(id)")
        
        mainFlowController.showMeteorDetails(meteorID: id)
        
        collectionViewSetup()
    }
    
    func nearingScrollEnd(year: Int) {
        print ("Nearing end of scroll") 
    }
    
    func collectionViewSetup() {
        
        let fetchedData = CoreDataManager.shared.fetchSavedData()
        
        //If not saved data fetch from API
        if fetchedData!.count == 0 {
            print ("Data empty")
            GetRequest.getMeteorList(self) { [weak self] (success, list) in
                if success, let list = list {
                    DataManager.shared.meteorList = list
                    self?.reloadCollectionView()
                } else {
                    self?.alert(message: "Could not load data as not found")
                }
            }
        } else { //Fetch from CoreData
            print ("data exists")
            let meteorList: [MeteorModel] = {
                var list = [MeteorModel]()
                for i in fetchedData! {
                    let meteor = MeteorModel(meteorID: i.meteorID,
                                             meteorSize: i.meteorSize,
                                             name: i.name,
                                             year: i.year,
                                             longitude: i.longitude,
                                             latitude: i.latitude)
                    list.append(meteor)
                }
                return list
            } ()
            DataManager.shared.meteorList = meteorList
            reloadCollectionView()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.meteorCollectionView.reloadData()
        }
    }
}
