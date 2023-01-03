//
//  ProfileViewController.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/7/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

// This UIViewController load user data using FirebaseFirestore
// persistent storage

class ProfileViewController: UIViewController {
    // singleton - shared data
    public static let shared = ProfileViewController()
    
    // outlet
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var numberOfSaved: UILabel!
    
    // use viewWillAppear to make sure it update
    override func viewWillAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            let email1 = user.email
            userEmail.text = email1
        }
        store.shared.saveDataFire(name: ImagesViewController.shared.storeName, add: ImagesViewController.shared.storeAdd, urls: ImagesViewController.shared.storeUrl)
        store.shared.loadDataFire()
        
        numberOfSaved.text = "\(ImagesViewController.shared.storeName.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // if user tapped signout
    @IBAction func signOut(_ sender: UIButton) {
        // sign out by firebase
        do {
            try Auth.auth().signOut()
            // after sign out, return to sign in page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "signIn")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        } catch let signOutError as NSError {
            // if any error, print it out
           print ("Error signing out: %@", signOutError)
        }
    }
}
