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
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = Database.database().reference()
        getUserCount()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getUserCount() {
        
        //Database reference
        ref = Database.database().reference()
        
        ref?.child("Users").observe(.value) { DataSnapshot in
            print(DataSnapshot.childrenCount)
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
                    print (self.userCount)
                    
                    //Search for user in Database using email
                    let userEmail = self.emailTextField.text!
                    print(userEmail)
                    
                    //Loop through users, compare if user email is equal to read email
                    for index in 0...self.userCount {
                        self.ref?.child("Users").observe(.value) { DataSnapshot in
                            
                            let usersDict = DataSnapshot.value as! Dictionary<String, Any>
                            //print(usersDict["User2"])
                            
                            let userDict = usersDict["User\(index)"] as! Dictionary<String, Any>
                            //print (userDict["Email"])
                            
                            let currentUserEmail = userDict["Email"] as! String
                            print(currentUserEmail)
                        }
                    }
                    
                    //Pull user data from Firebase
//                    self.ref?.child("Users").child("userNum?").observe(.value) { DataSnapshot in
//                        //Query
//
//                    }
                    
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


}

