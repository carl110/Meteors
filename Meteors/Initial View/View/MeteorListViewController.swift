//
//  ViewController.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import UIKit
import CoreData

class MeteorListViewController: UIViewController, MeteorCellSelectedDelegate {
    
    fileprivate var flowController: MeteorListFlow!
    fileprivate var viewModel = MeteorListViewModel()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var meteorCollectionView: CustomCollectionView!
    
    func assignDependencies(flowController: MeteorListFlow) {
        self.flowController = flowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        collectionViewSetup()
    }
    
    func initialSetup() {
        navigationController?.isNavigationBarHidden = true
        setBackgroundImageStreched()
        titleLabel.titleLabelSetUp(text: "Add Meteor to Map to View/Compare")
        meteorCollectionView.cellDelegate = self
        
        //set layout of collectionview cells
        let layout = UICollectionViewFlowLayout()
        self.meteorCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func collectionViewSetup() {
        fetchSavedMeteorList()

        //If no saved data or the data was last fetched more then 1 day ago fetch from API
        let fetchedData = CoreDataManager.shared.fetchSavedData()
        if fetchedData!.count == 0 || viewModel.daysSinceLastUpdate() > 1 {
            fetchDataFromAPI()
        }
    }
    
    func fetchSavedMeteorList() {
        if let fetchedData = CoreDataManager.shared.fetchSavedData() {
            let meteorList: [MeteorListModel] = {
                var list = [MeteorListModel]()
                for i in fetchedData {
                    let meteor = MeteorListModel(meteorID: i.meteorID,
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
    
    func cellWasSelected(id: String) {
        Singleton.sharedInstance.meteorID = id
        tabBarController?.selectedIndex = 1
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
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.meteorCollectionView.reloadData()
        }
    }
}
