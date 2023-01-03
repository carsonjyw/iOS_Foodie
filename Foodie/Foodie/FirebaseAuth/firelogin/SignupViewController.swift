//
//  SignupViewController.swift
//  MusicMaster
//  Name: Carson Wang
//  Email: carsonw@usc.edu
//  Created by Carson Wang on 12/3/22.
//

import UIKit
import FirebaseAuth

// This file using FirebaseAuth to let user sign in to the app

class SignupViewController: UIViewController, UITextFieldDelegate {
    // outlet
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        // make sure when user tap outside of the keyboard,
        // keyboard dismiss
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        self.email.delegate = self
        self.password.delegate = self
        self.password.isSecureTextEntry = true
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
    
    @IBAction func SignupDidTapped(_ sender: UIButton) {
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
        // else call the sign up
        signup()
    }
    
    func signup() {
        // using the firebase to sign up
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            // check if any error
            if error == nil {
                // if no error, pass user to main page
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "mainHome")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            } else{
                // if there is, print altert to show user the error
                let alert = UIAlertController(title: "Warning!", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(actionOK)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
