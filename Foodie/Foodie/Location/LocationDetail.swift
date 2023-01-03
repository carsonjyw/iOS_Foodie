//  Name: Carson Wang
//  Email: carsonw@usc.edu

import CoreLocation
import Foundation

// This file help us to get user's current location
// Using CoreLocation

class LocationDetail: NSObject, CLLocationManagerDelegate {
    
    // Create an instance
    static let shared = LocationDetail()
    var manager: CLLocationManager!
    var startPoint: CLLocation?
    var distanceFromStart = 0.0

    var completion: ((CLLocation) -> Void)?
    
    // to get current location in other file
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        self.manager = CLLocationManager()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        // request permisson
        self.manager.requestWhenInUseAuthorization()
        // start location
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        
        // stop location
        manager.stopUpdatingLocation()
    }
    
    // print error message if can't get location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Could not get location")
        
    }
}
