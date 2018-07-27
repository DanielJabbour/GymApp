//
//  ViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-05-19.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    var ref: DatabaseReference?
    var userCount = 0;
    var userDictionary = [String: String]()
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Database reference
        ref = Database.database().reference()
        
        //Get user count from database for search
        getUserCount()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getUserCount() {
        
        //Database reference
        ref = Database.database().reference()
        
        //Get count of users -1 to use in search loop
        ref?.child("Users").observe(.value) { DataSnapshot in
            //print(DataSnapshot.childrenCount)
            self.userCount = Int(DataSnapshot.childrenCount) - 1
        }
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            //Check if user input is blank and create/display error message
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            //Call Firebase auth object and use signIn function to sign user in
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                //Error handling
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    self.searchUsers{ success in
                        if success {
                            print("success")
                            print(self.userDictionary)
                        }
                        else {
                            print("fail")
                        }
                    }
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Displays error message
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func searchUsers(completion: @escaping (Bool) -> ()) {
        ref?.child("Users").observeSingleEvent(of: .value, with: { (DataSnapshot) in
            
            let dataSnap = DataSnapshot.value as? [String:Any]
            let userEmail = self.emailTextField.text;
            
            for index in 0...self.userCount {
                var userData = dataSnap!["User\(index)"] as! [String:String]
                let currentUserEmail = userData["Email"]
                
                if (currentUserEmail == userEmail) {
                    print("Found User")
                    self.userDictionary = userData
                    break;
                }
            }
            
            completion(true)
        })
    }
    
}

