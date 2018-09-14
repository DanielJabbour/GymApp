//
//  SettingsViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-05-20.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    var ref: DatabaseReference!
    let userID = UserDefaults.standard.object(forKey: "UserID") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearDataAction(_ sender: Any) {
        //Method to clear muscle data
        
        let ref1MuscleGroupsNew = self.ref.child("Users").child(self.userID).child("MuscleGroupsNew")
        let ref2MuscleGroupsOld = self.ref.child("Users").child(self.userID).child("MuscleGroupsOld")

        ref1MuscleGroupsNew.removeValue { (error, _) in
            print(error ?? "No Error")
        }
        ref2MuscleGroupsOld.removeValue { (error, _) in
            print(error ?? "No Error")
        }
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        //Method for signing users out
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
