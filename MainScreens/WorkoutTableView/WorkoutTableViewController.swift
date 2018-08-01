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

        //Load sample data
        //loadSampleData()
        
        print(self.muscleGroup)
        print(self.userID)
        
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
        cell.setsLabel.text = String(workout.sets)
        cell.repsLabel.text = String(workout.reps)
        cell.weightLabel.text = String(workout.weight)
        
        return cell
    }
    
    // MARK: - Data manipulation methods
    
    private func loadSampleData() {
        
        guard let newWorkout1 = Workout(name: "Bench", sets:3, reps:5, weight:200) else {
            fatalError("Unable to instantiate workout")
        }
        
        workouts += [newWorkout1]
//        self.tableView.reloadData()
        
    }
    
    @IBAction func workoutAddButton(_ sender: Any) {
        addItem()
    }
    
    private func addItem() {
        
        //Create alert controller
        let alert = UIAlertController(title: "Add a Workout", message: "Enter a new workout", preferredStyle: .alert)
        
        //Create reference to database
        ref = Database.database().reference()
        
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

}
