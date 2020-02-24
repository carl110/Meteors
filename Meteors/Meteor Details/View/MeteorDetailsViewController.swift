//
//  MeteorDetailsViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit
import MapKit

class MeteorDetailsViewController: UIViewController {
    
    fileprivate var flowController: MeteorDetailsFlowController!
    fileprivate var viewModel: MeteorDetailsViewModel!
    
    @IBOutlet weak var meteorName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goBackButton: UIButton!
    
    private var longitude = Double()
    private var latatude = Double()
    private var rockName = String()
    
    func assignDependancies(flowController: MeteorDetailsFlowController, viewModel: MeteorDetailsViewModel) {
        self.viewModel = viewModel
        self.flowController = flowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabelSetup()
        setup()
        buttonSetup()
        mapPinSetup()
    }
    
    func setup() {
        setBackgroundImageStreched()
        let fetchedData = CoreDataManager.shared.fetchDataForID(meteorID: viewModel.meteorID)
        
        for data in fetchedData! {
            print ("long = \(data.latitude)")
            longitude = Double(data.longitude)!
            latatude = Double(data.latitude)!
            rockName = data.name

            if longitude + latatude == 0 {
                meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n\n   Location Data Currently Unavailable..."
            } else {
                meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n   Lat:          \(latatude)\n   Long:       \(longitude)"
            }
        }
    }
    
    func buttonSetup() {
        goBackButton.setTitle("View full list of Meteors", for: .normal)
        goBackButton.buttonSetup()
    }
    
    func dataLabelSetup() {
        meteorName.backgroundColor = UIColor.clear
        meteorName.numberOfLines = 5
        meteorName.textAlignment = .left
        meteorName.font = UIFont.boldSystemFont(ofSize: meteorName.bounds.height / 12)
        meteorName.adjustsFontSizeToFitWidth = true
        meteorName.textColor = UIColor.Shades.standardWhite
        meteorName.layer.borderWidth = 4
        meteorName.layer.borderColor  = UIColor.Yellows.mustardYellow.cgColor
    }
    
    func mapPinSetup() {
        
        //Create the pin location
        let meteorLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latatude), longitude: CLLocationDegrees(longitude))
        
        //Center the map on the place location
        mapView.setCenter(meteorLocation, animated: true)
        
        //Add titles to pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latatude, longitude: longitude)
        annotation.title = "\(rockName)"
        annotation.subtitle = "\(latatude) \(longitude)"
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        //remove top viewcontroller
        self.popBack(2)
    }
}
