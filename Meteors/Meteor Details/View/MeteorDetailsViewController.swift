//
//  MeteorDetailsViewController.swift
//  table setp
//
//  Created by Carl Wainwright.
//  Copyright © 2019 Carl Wainwright. All rights reserved.
//

import UIKit
import MapKit

class MeteorDetailsViewController: UIViewController, MKMapViewDelegate {
    
    fileprivate var flowController: MeteorDetailsFlow!
    
    @IBOutlet weak var meteorName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var goBackButton: UIButton!
    
    private var longitude = Double()
    private var latitude = Double()
    private var rockName = String()
    
    func assignDependencies(flowController: MeteorDetailsFlow) {
        self.flowController = flowController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        if !Singleton.sharedInstance.meteorID.isEmpty{
            getMeteorData()
            setRegion()
            setAnnotation()
        } else {
            alert(message: "The meteor you selected does not have the required information to show further details\n\nPlease select a different Meteor")
        }
    }
    
    func initialSetup() {
        mapView.delegate = self
        mapView.mapType = .hybrid
        mapView.showsScale = true
        self.navigationController?.isNavigationBarHidden = true
        setBackgroundImageStreched()
        meteorName.meteorDataLabelSetup()
        goBackButton.buttonSetup(title: "Back to Meteor List")
    }
    
    //Set map center from long & lat
    func setRegion() {
        let meteorLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        let span = MKCoordinateSpan.init(latitudeDelta: 50, longitudeDelta: 50)
        let region = MKCoordinateRegion.init(center: (meteorLocation), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    //Add titles to pin
    func setAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "\(rockName)"
        if latitude == 37.563936 && longitude == -116.85123 {
            annotation.subtitle = "Location data is unavailable"
        } else {
            annotation.subtitle = "\(latitude) \(longitude)"
        }
        mapView.addAnnotation(annotation)
    }
    
    //Set custom annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "chevron")
        }
        return annotationView
    }

    func getMeteorData() {
        
        //Fetch data from CoreData using the meteorID
        if let fetchedData = CoreDataManager.shared.fetchDataForID(meteorID: Singleton.sharedInstance.meteorID) {
            for data in fetchedData {
                longitude = Double(data.longitude) ?? 0
                latitude = Double(data.latitude) ?? 0
                rockName = data.name
                
                //If lon lat is 0 set to giant target
                if longitude + latitude == 0 {
                    longitude = -116.85123
                    latitude = 37.563936
                    meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n\n   Location Data Currently Unavailable..."
                } else {
                    meteorName.text = "   Name:      \(data.name)\n   Mass:       \(data.meteorSize)g\n   Year:         \(data.year.prefix(4))\n   Lat:          \(latitude)\n   Long:       \(longitude)"
                }
            }
        }
    }

    @IBAction func goBackButton(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
}
