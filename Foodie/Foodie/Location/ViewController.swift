//
//  ViewController.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/6/22.
//

import CoreLocation
import MapKit
import UIKit

// This ViewController load data from Yelp API using the current location from LocationDetail file. Then using the mapkit to add annotations on the map.
// Using MapKit

class ViewController: UIViewController {
    
    // outlet
    @IBOutlet weak var map: MKMapView!
    
    // create varibles to hold data loaded from Yelp API
    var name: [String] = []
    var latitude: [Double] = []
    var longitude: [Double] = []
    
    override func viewWillAppear(_ animated: Bool) {
        // add title
        title = "Map"
        // calling the LocationDetail to get current location
        LocationDetail.shared.getUserLocation { location in
            DispatchQueue.main.async {
                // calling the YelpAPI file to pass the location and load the data
                YelpAPI.shared.getImages{ images in
                    DispatchQueue.main.async {
                        YelpAPI.shared.yelp = images
                        // from loaded data, get the data we want and append them into varibles
                        for x in 0..<YelpAPI.shared.yelp.count{
                            for i in YelpAPI.shared.yelp[x].businesses{
                                self.name.append(i.name!) // name
                                self.latitude.append((i.coordinates?.latitude)!) // latitude
                                self.longitude.append((i.coordinates?.longitude)!) // longitude
                            }
                        }
                        // create location
                        self.createAnnotation(name: self.name, latitude: self.latitude, longitude: self.longitude, location: location)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // this function is to create annotation on map
    // parameters are name, latitude, longitude, and current location
    func createAnnotation(name: [String], latitude: [Double], longitude: [Double], location: CLLocation) {
        // add pin for user current location on map
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = "Your location"
        map.addAnnotation(pin)
        
        // set overall map ciew
        map.setRegion(MKCoordinateRegion(
                        center: location.coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.05,
                            longitudeDelta: 0.05
                        )
        ),
                      animated: true)
        
        // add pin for other store location on map
        // using for loop to loop through the arrays
        for x in 0..<self.name.count{
            let notation = MKPointAnnotation()
            notation.title = name[x]
            notation.coordinate = CLLocationCoordinate2D(latitude: latitude[x], longitude: longitude[x])
            map.addAnnotation(notation)
        }
    }
}

