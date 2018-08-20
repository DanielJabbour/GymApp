//
//  MuscleTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-06-23.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MuscleTableViewController: UITableViewController {

    var muscles = [Muscle]()
    var ref: DatabaseReference!
    var userCount = 0;
    var muscleGroupCount = 0;
    var userID = ""
    let email = UserDefaults.standard.object(forKey: "UserEmail") as! String

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Programatically configuring navigation components (title, left, right buttons)
        navigationItem.title = "Muscle groups"
        
        //Create a reference to the database
        ref = Database.database().reference()
        
        //Get count of users in database
        getUserCount()
        
        //Load initial user data
        matchUser()
        
        //Load Muscle Groups
        loadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    //Only 1 secion to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return muscles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MuscleTableViewCell"
        
        //Use of custom class Muscle hence need to downcast type of cell to custom cell subclass
        //as? MuscleTableView cell attempts to downcast to MuscleTableViewCell class returning an optional
        //Guard let unwraps optional safely
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MuscleTableViewCell else {
            fatalError("The dequed cell is not an instance of MuscleTableViewCell")
        }
        
        //Fetch appropriate muscle group from array
        let muscle = muscles[indexPath.row]
        
        //Configuring cell
        cell.WorkoutName.text = muscle.group

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Passing data to workout controller
        let workoutTableViewController = storyboard?.instantiateViewController(withIdentifier: "WorkoutTableView") as! WorkoutTableViewController
        let selected = muscles[indexPath.row]
        
        workoutTableViewController.muscleGroup = selected.group
        workoutTableViewController.userID = self.userID
        
        self.navigationController?.pushViewController(workoutTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            remove(child: muscles[indexPath.row].group)
            muscles.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Configuration and data manipulation methods
    
    private func remove(child: String) {
        let ref = self.ref.child("Users").child(self.userID).child("MuscleGroupsNew").child(child)
        
        ref.removeValue { (error, _) in
            print(error ?? "No Error")
        }
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        addItem()
    }
    
    private func addItem() {
        
        //Create alert controller
        let alert = UIAlertController(title: "Add a Muscle Group", message: "Enter a new muscle group", preferredStyle: .alert)
        
        //Create reference to database
        ref = Database.database().reference()
        
        //Add text input field
        alert.addTextField{ (textField) in
            textField.text = ""
        }
        
        
        //Grab and log user entered value
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0].text
            
            guard let newMuscle = Muscle(group: textField!) else {
                fatalError("Unable to instantiate muscle")
            }
            
            //Push entry to database under appropriate user
            //self.ref?.child("Users").child(self.userID).child("MuscleGroups").child("MuscleGroup\(self.muscleGroupCount)").setValue(textField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(textField!).child("Workouts").child("Dummy").setValue("Value")
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(textField!).child("Workouts").child("Dummy").setValue("Value")

            self.muscleGroupCount += 1
            
            self.muscles += [newMuscle]
            self.tableView.reloadData()

        }))
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func matchUser() {
        ref?.child("Users").observeSingleEvent(of: .value, with: { DataSnapshot in
            let dataSnap = DataSnapshot.value as? [String:Any]
            let userEmail = self.email
            
            for index in 0...self.userCount {
                var userData = dataSnap!["User\(index)"] as! [String:Any?]
                let currentUserEmail = userData["Email"] as! String
                
                if (currentUserEmail == userEmail) {
                    self.userID = "User\(index)"
                    break;
                }
            }
            
        })
        
    }
    
    private func loadData() {
        ref?.child("Users").observeSingleEvent(of: .value, with: { DataSnapshot in
            
            let userData = DataSnapshot.value as? [String:Any]
            let User = userData![self.userID] as? [String:Any]
            
            //Check if user has any pre set muscle groups. If there is no child node MuscleGroups, return
            guard User!["MuscleGroupsNew"] != nil else {
                return
            }
            
            let muscleGroupList = User!["MuscleGroupsNew"] as! [String:Any]
            
            //TO DO: Implement algorithm to load all muscle groups from muscle group list by searching and instantiating each group
            for (key, _) in muscleGroupList {
                
                let currentMuscleGroup = key
                
                guard let newMuscle = Muscle(group: currentMuscleGroup) else {
                    fatalError("Unable to instantiate muscle")
                }
                
                self.muscles += [newMuscle]
            }
            
            //Get rid of dummy value if exists

            self.tableView.reloadData()
            
        })
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
    
}

