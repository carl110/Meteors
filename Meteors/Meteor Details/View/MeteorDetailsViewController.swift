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
    
    var longitude = 59.6
    var latatude = 17.2
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
        


        //Create the pin location of your restaurant(you need the GPS coordinates for this)
         let meteorLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latatude), longitude: CLLocationDegrees(longitude))

        //Center the map on the place location
        mapView.setCenter(meteorLocation, animated: true)

        // Do any additional setup after loading the view.
        
        addPin()
    }
    
    func setup() {
        
        setBackgroundImageStreched()
        
        let fetchedData = CoreDataManager.shared.fetchDataForID(meteorID: viewModel.meteorID)
        
        
        for data in fetchedData! {
            print ("long = \(data.latitude)")
            longitude = Double(data.longitude)!
            latatude = Double(data.latitude)!
            rockName = data.name
           
           //            meteorName.dataLabelSetup()
            if longitude + latatude == 0 {
                print ("NO Location")

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
    
    func addPin() {
        let annotation = MKPointAnnotation()
 annotation.coordinate = CLLocationCoordinate2D(latitude: latatude, longitude: longitude)
        annotation.title = "\(rockName)"
        //You can also add a subtitle that displays under the annotation such as
        annotation.subtitle = "\(latatude) \(longitude)"
        
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func goBackButton(_ sender: Any) {
//        flowController.showMain()
        self.popBack(2)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
