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
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var userEmail = ""
    var userID = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            print("OK")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    self.userEmail = self.emailTextField.text!
                    
                    //Store user email in user defaults as we'll need it later for database reference purposes
                    UserDefaults.standard.set(self.userEmail, forKey: "UserEmail")
                    
                    //Find userID
                    self.ref?.child("Users").observeSingleEvent(of: .value, with: { DataSnapshot in
                        let dataSnap = DataSnapshot.value as? [String:Any]
                        let userCount = dataSnap!.count as Int
                        
                        for index in 0...userCount {
                            var userData = dataSnap!["User\(index)"] as! [String:Any?]
                            let currentUserEmail = userData["Email"] as! String
                            
                            if (currentUserEmail == self.userEmail) {
                                print("Found User")
                                self.userID = "User\(index)"
                                
                                //Set userID to nsdefault
                                UserDefaults.standard.set(self.userID, forKey: "UserID")
                                break;
                            }
                        }
                        //Go to the HomeViewController if the login is sucessful
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        self.present(vc!, animated: true, completion: nil)
                    })
                    
                    
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
    
}

