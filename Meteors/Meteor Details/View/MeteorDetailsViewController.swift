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
    private var latitude = Double()
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
        
        //Fetch data from CoreData using the meteorID
        if let fetchedData = CoreDataManager.shared.fetchDataForID(meteorID: viewModel.meteorID) {
            for data in fetchedData {
                
                longitude = Double(data.longitude) ?? 0
                latitude = Double(data.latitude) ?? 0
                rockName = data.name
                
                if longitude + latitude == 0 {
                    longitude = -77.0098
                    latitude = 38.8765
                    meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n\n   Location Data Currently Unavailable..."
                } else {
                    meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n   Lat:          \(latitude)\n   Long:       \(longitude)"
                }
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
        let meteorLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        
        //Center the map on the meteor landind location
        mapView.setCenter(meteorLocation, animated: true)
        
        //Add titles to pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(rockName)"
        if latitude + longitude == 0 {
            annotation.subtitle = "Location data is unavailable"
        } else {
            annotation.subtitle = "\(latitude) \(longitude)"
        }
        mapView.addAnnotation(annotation)
    }
    
    deinit {
        mapView.showsUserLocation = false
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        mapView.removeFromSuperview()
        mapView.delegate = nil
    }
    
    @IBAction func goBackButton(_ sender: Any) {
        
        //remove top viewcontroller
        self.popBack(2)
    }
}
