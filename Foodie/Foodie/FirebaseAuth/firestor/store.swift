//
//  store.swift
//  Foodie
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/7/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

// This file create general function to save and load data from firebase

class store{
    // singleton - sharing
    public static let shared = store()
    
    // load data method
    public func loadDataFire() {
        // get current auth, user info
        if let user = Auth.auth().currentUser {
            let email1 = user.email
            let docRef = Firestore.firestore().collection("user")
                .document(email1!)
            docRef.getDocument { (documentSnapshot, error) in
                if let documentSnapshot = documentSnapshot,
                       documentSnapshot.exists {
                    // save the data into local variables
                    let a = documentSnapshot.data() as? [String: [String]]
                    ImagesViewController.shared.storeName = a!["Name"]!
                    ImagesViewController.shared.storeUrl = a!["URL"]!
                    ImagesViewController.shared.storeAdd = a!["Add"]!
                 } else {
                     // if there is an error, print
                    print("Document does not exist")
                 }
            }
        }
    }
    
    // save data method
    // taking three parameters name: [String], add: [String], urls: [String]
    public func saveDataFire(name: [String], add: [String], urls: [String]) {
        // get current user email
        if let user = Auth.auth().currentUser {
            let email1 = user.email
            // set up the data and store them
            Firestore.firestore().collection("user").document(email1!).setData([
                "Name" : name,
                "Add": add,
                "URL": urls
            ]) { err in // check if there is an error
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
}
