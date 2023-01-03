//
//  ViewController.swift
//  MusicMaster
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/3/22.
//

import UIKit
import FirebaseAuth

// This file using FirebaseAuth to let user sign in to the app

class LogInController: UIViewController, UITextFieldDelegate {
    // outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var toggleButton: UIButton!
    
    var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // make sure when user tap outside of the keyboard,
        // keyboard dismiss
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        self.email.delegate = self
        self.password.delegate = self
        self.password.isSecureTextEntry = true
    }
    
    @IBAction func toggleButtonTapped(_ sender: Any) {
        isPasswordVisible = !isPasswordVisible
        password.isSecureTextEntry = !isPasswordVisible

        if isPasswordVisible {
            toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // tap on next, return to another textfild
        if textField == email {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            // tap on done, exist the textfild
            textField.resignFirstResponder()
        }
        return true
    }

    // when user tapped log in button
    @IBAction func LogInDidTapped(_ sender: UIButton) {
        // check if the email field is empty
        if email.text?.isEmpty == true {
            print("No email entered")
            // if empty show alter
            let alert = UIAlertController(title: "Warning!", message: "No email entered.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
            return
        }
        // check if the password field is empty
        if password.text?.isEmpty == true {
            print("No password entered")
            // if empty show alter
            let alert = UIAlertController(title: "Warning!", message: "No password entered.", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(actionOK)
            self.present(alert, animated: true, completion: nil)
            return
        }
        // else pass sign in
        signin()
    }
    
    func signin() {
        // using the firebase to sign in
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { authResult, error in
            // if there is no error
            if error == nil {
                // pass the firebase firestore to load past data
                store.shared.loadDataFire()
                // check if info is nil and load them into main page
                self.checkInfo()
            } else{ // if there is an error
                // using alter to show user the error
                let alert = UIAlertController(title: "Warning!", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(actionOK)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func checkInfo(){
        // is not nil
        if Auth.auth().currentUser != nil {
            // rediect user to main page
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        } else { // else return
            return
        }
    }
    
    
}

