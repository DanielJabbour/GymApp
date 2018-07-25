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
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = Database.database().reference()
        
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
                    
                    //Search for user in Database using email
                    var userEmail = self.emailTextField.text!
                    self.ref?.child("Users").observe(.value) { DataSnapshot in
                        
                        let usersDict = DataSnapshot.value as! Dictionary<String, Any>
                        print(usersDict["User2"])
                        
                        let userDict = usersDict["User2"] as! Dictionary<String, Any>
                        print (userDict["Email"])
                        
                        let currentUserEmail = userDict["Email"] as! String
                        print(currentUserEmail)
                        
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

