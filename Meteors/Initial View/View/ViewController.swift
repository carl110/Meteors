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
    fileprivate var viewModel: MainViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var meteorCollectionView: CustomCollectionView!
    
    func assignDependancies(mainFlowController: MainFlowController) {
        self.mainFlowController = mainFlowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        mainFlowController.showMeteorDetails(meteorID: id)
    }
    
    func collectionViewSetup() {
        fetchSavedMeteorList()

        //If no saved data or the data was last fetched before today then fetch from API
        let fetchedData = CoreDataManager.shared.fetchSavedData()
        if fetchedData!.count == 0 || daysSinceLastUpdate() > 0 {
            print ("if condition met")
            fetchDataFromAPI()
        }
    }
    
    func fetchDataFromAPI() {
        DispatchQueue.main.async { [weak self] in
            GetRequest.getMeteorList(self!) { (success, list) in
                if success, let list = list {
                    DataManager.shared.meteorList = list
                    self?.reloadCollectionView()
                } else {
                    self?.alert(message: "Unable to fetch Meteor Data from NASA at this time")
                }
            }
        }
    }
    
    func fetchSavedMeteorList() {
        if let fetchedData = CoreDataManager.shared.fetchSavedData() {
        
        let meteorList: [MeteorModel] = {
            var list = [MeteorModel]()
            for i in fetchedData {
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
    
    func daysSinceLastUpdate() -> Int{
        let fetchedData = CoreDataManager.shared.fetchSavedData()
        var daysSinceUpdate = Int()
        for i in fetchedData! {
            daysSinceUpdate = i.dateOfUpdate.numberOfDaysToToday()
            break
        }
        return daysSinceUpdate
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.meteorCollectionView.reloadData()
        }
    }
}
