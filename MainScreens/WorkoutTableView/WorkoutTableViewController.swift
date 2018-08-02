//
//  WorkoutTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-07-30.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WorkoutTableViewController: UITableViewController {

    var workouts = [Workout]()
    var ref: DatabaseReference!
    var muscleGroup = "FAILED"
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create reference to database
        ref = Database.database().reference()

        //Load data from database
        loadData()
        
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
        return workouts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WorkoutTableViewCell"
        
        //Use of custom class Muscle hence need to downcast type of cell to custom cell subclass
        //as? WorkoutTableView cell attempts to downcast to WorkoutTableViewCell class returning an optional
        //Guard let unwraps optional safely
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorkoutTableViewCell else {
            fatalError("The dequed cell is not an instance of WorkoutTableViewCell")
        }
        
        //Fetch appropriate muscle group from array
        let workout = workouts[indexPath.row]
        
        //Configuring cell
        cell.workoutNameLabel.text = workout.name
        cell.setsLabel.text = "Sets: " + String(workout.sets)
        cell.repsLabel.text = "Reps: " + String(workout.reps)
        cell.weightLabel.text = "Weight: " + String(workout.weight)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            remove(child: workouts[indexPath.row].name)
            workouts.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Data manipulation methods
    
    private func remove(child: String) {
        let ref = self.ref.child("Users").child(self.userID).child("MuscleGroups").child(self.muscleGroup).child("Workouts").child(child)
        
        ref.removeValue { (error, _) in
            print(error ?? "No Error")
        }
    }
    
    @IBAction func workoutAddButton(_ sender: Any) {
        addItem()
    }
    
    private func addItem() {
        
        //Create alert controller
        let alert = UIAlertController(title: "Add a Workout", message: "Enter a new workout", preferredStyle: .alert)
        
        //Add text input field
        alert.addTextField{ (textField) in
            textField.placeholder = "Workout Name"
        }
        
        alert.addTextField{ (textField) in
            textField.placeholder = "Sets"
            textField.keyboardType = .numberPad
        }
        
        alert.addTextField{ (textField) in
            textField.placeholder = "Reps"
            textField.keyboardType = .numberPad
        }
        
        alert.addTextField{ (textField) in
            textField.placeholder = "Weight"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            //Add on action method here
            
            
            let nameTextField = alert?.textFields![0].text
            let setsTextField = Int((alert?.textFields![1].text)!)
            let repsTextField = Int((alert?.textFields![2].text)!)
            let weightTextField = Int((alert?.textFields![3].text)!)
            
            
            guard let newWorkout = Workout(name: nameTextField!, sets: setsTextField!, reps: repsTextField!, weight: weightTextField!) else {
                fatalError("Unable to instantiate workout")
            }
            
            //Push entry to database under appropriate user
            self.ref?.child("Users").child(self.userID).child("MuscleGroups").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Sets").setValue(setsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroups").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Reps").setValue(repsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroups").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Weight").setValue(weightTextField)
            
            self.workouts += [newWorkout]
            self.tableView.reloadData()
            
        }))

        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadData() {
        ref?.child("Users").observeSingleEvent(of: .value, with: { DataSnapshot in
            
            let userData = DataSnapshot.value as? [String:Any]
            let User = userData![self.userID] as? [String:Any]
            
            //Check if user has any pre set muscle groups. If there is no child node MuscleGroups, return
            guard User!["MuscleGroups"] != nil else {
                return
            }
            
            let muscleGroupsDict = User!["MuscleGroups"] as! [String:Any]
            let muscleDict = muscleGroupsDict[self.muscleGroup] as! [String:Any]
            let workoutsDict = muscleDict["Workouts"] as! [String:Any]
            
            for (key, _) in workoutsDict {
                
                if (key != "Dummy"){
                    var workoutScheme = workoutsDict[key] as! [String: Int]
                    
                    let sets = workoutScheme["Sets"]
                    let reps = workoutScheme["Reps"]
                    let weight = workoutScheme["Weight"]
                    
                    let newWorkout = Workout(name: key, sets: sets!, reps: reps!, weight: weight!)!
                    self.workouts += [newWorkout]

                }
                
            }
            self.tableView.reloadData()
            
            
        })
    }

}
