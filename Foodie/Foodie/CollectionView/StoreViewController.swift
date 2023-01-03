//
//  StoreViewController.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/6/22.
//

import UIKit
import Kingfisher
import EventKit
import EventKitUI

// This UIViewController allow user to view the detail info about the store
// Allowing user to add event into their calendar & save the store & redirect them to webpage

class StoreViewController: UIViewController, EKEventEditViewDelegate {
    // outlets
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var website: UIButton!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    
    // local varibles
    var url: URL!
    var name1: String!
    var phone1: String!
    var address1: String!
    var city1: String!
    var type1: String!
    var url_page: String!
    
    // for event kit
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set label info
        self.storeImage.kf.setImage(with: self.url)
        self.name.text = name1
        self.phone.text = phone1
        self.address.text = address1
        self.city.text = city1
        self.type.text = type1
    }
    
    // MARK: Redict user to webpage
    @IBAction func buttonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: url_page)! as URL, options: [:], completionHandler: nil)
    }
    
    // MARK: Blow are for add event
    
    // when user finish editing dismiss
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // when user click on add event button
    @IBAction func buttonEvent(_ sender: UIButton) {
        // request user to allow access
        eventStore.requestAccess(to: .event) { success, error in
                    if success, error == nil {
                        // if no error, call presentEvent() to add event
                        DispatchQueue.main.async {
                            presentEvent()
                        }
                    }
                }
        
        func presentEvent() {
            // create basic variables
            let eventVC = EKEventEditViewController()
            eventVC.editViewDelegate = self
            eventVC.eventStore = EKEventStore()
            
            // editing the basic info for user
            let event = EKEvent(eventStore: eventVC.eventStore)
            event.title = "Meal at " + name1
            event.url = URL(string: url_page)
            event.location = address1 + ", " + city1
            event.startDate = Date()
            event.endDate = Date()
            
            eventVC.event = event
            // present event
            self.present(eventVC, animated: true, completion: nil)
        }
    }
    
    // MARK: Blow are for save the store into data
    @IBAction func saveButton(_ sender: UIButton) {
        // check if the store user want to save is already saved
        if ImagesViewController.shared.storeName.contains(name1){
            // if yes, show alter to user
            let alert = UIAlertController(title: "Warning!", message: "The store you want to save is already saved.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
        } else{
            // else, show altert to user that they saved the store
            let alert = UIAlertController(title: "Store Saved", message: "You've successfully saved this store.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
            // add data
            ImagesViewController.shared.storeName.append(name1)
            ImagesViewController.shared.storeAdd.append(address1)
            ImagesViewController.shared.storeUrl.append(url_page)
        }
    }
}
