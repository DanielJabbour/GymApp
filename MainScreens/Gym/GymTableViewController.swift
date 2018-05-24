//
//  GymTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-05-21.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class GymTableViewController: UITableViewController {

    //Initialize an empty array of workout objects
    var workouts = [workout]()
    
    private func loadSampleWorkout() {
        guard let workout1 = workout(title: "Bench Press", reps: 10, sets: 3) else {
            fatalError("Unable to represent workout")
        }
        
        guard let workout2 = workout(title: "Dumbell Press", reps: 10, sets: 3) else {
            fatalError("Unable to represent workout")
        }
        
        guard let workout3 = workout(title: "Pec flys", reps: 10, sets: 3) else {
            fatalError("Unable to represent workout")
        }
        
        workouts += [workout1,workout2,workout3]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleWorkout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // returns the length of workouts array
        return workouts.count
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "workoutTableViewCell"
        
        //Attempt to downcast type of cell to the custom cell subclass. Returns optional which is then unwrapped by guard
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WorkoutCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of workoutTableViewCell.")

        }
        
        //Fetches appropriate workout from workouts array
        let workout = workouts[indexPath.row]

        //Configuring cell content from user input
        cell.titleOutlet.text = workout.title
        cell.setsOutlet.text = String(workout.sets)
        cell.repsOutlet.text = String(workout.reps)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
