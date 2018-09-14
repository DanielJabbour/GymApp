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
        let ref = self.ref.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(child)
        
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
            
            let randInt = Int(arc4random_uniform(999999999))
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let resultDate = formatter.string(from: date)
            
            //Push entry to database under appropriate user
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Sets").setValue(setsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Reps").setValue(repsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Weight").setValue(weightTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Date").setValue(resultDate)
            
            //Add unique identifier for repretitions, firebase rejects duplicate entries
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Sets").setValue(setsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Reps").setValue(repsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Weight").setValue(weightTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Date").setValue(resultDate)

            self.workouts += [newWorkout]
            
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    //Load data method
    private func loadData() {
        ref?.child("Users").observeSingleEvent(of: .value, with: { DataSnapshot in
            
            let userData = DataSnapshot.value as? [String:Any]
            let User = userData![self.userID] as? [String:Any]
            
            //Check if user has any pre set muscle groups. If there is no child node MuscleGroups, return
            guard User!["MuscleGroupsNew"] != nil else {
                return
            }
            
            let muscleGroupsDict = User!["MuscleGroupsNew"] as! [String:Any]
            let muscleDict = muscleGroupsDict[self.muscleGroup] as! [String:Any]
            let workoutsDict = muscleDict["Workouts"] as! [String:Any]
            
            for (key, _) in workoutsDict {
                
                if (key != "Dummy"){
                    var workoutScheme = workoutsDict[key] as! [String: AnyObject]
                    
                    let sets = workoutScheme["Sets"] as! Int
                    let reps = workoutScheme["Reps"] as! Int
                    let weight = workoutScheme["Weight"] as! Int
                    
                    let newWorkout = Workout(name: key, sets: sets, reps: reps, weight: weight)!
                    self.workouts += [newWorkout]

                }
                
                else if (workoutsDict.count > 1 && key == "Dummy"){
                    self.remove(child: "Dummy")
                }
                
            }
            self.tableView.reloadData()
            
        })
    }
    
    //Method to update data. When you tap the current row, you can edit it to update your latest session. An additional data entry is then entered into the DB, but only the latest is displayed on your screen.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            
            let randInt = Int(arc4random_uniform(999999999))
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-y yyy"
            let resultDate = formatter.string(from: date)
            
            //Push entry to database under appropriate user
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Sets").setValue(setsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Reps").setValue(repsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Weight").setValue(weightTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsNew").child(self.muscleGroup).child("Workouts").child(nameTextField!).child("Date").setValue(resultDate)

            
            //Add unique identifier for repretitions, firebase rejects duplicate entries
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Sets").setValue(setsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Reps").setValue(repsTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Weight").setValue(weightTextField)
            self.ref?.child("Users").child(self.userID).child("MuscleGroupsOld").child(self.muscleGroup).child("Workouts").child(nameTextField! + "\(randInt)").child("Date").setValue(resultDate)
            
            self.workouts += [newWorkout]
            
            self.workouts.remove(at: indexPath.row)
            
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
        
        
    }

}
