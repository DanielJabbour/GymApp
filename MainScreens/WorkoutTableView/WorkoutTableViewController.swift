//
//  WorkoutTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-07-30.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

    var workouts = [Workout]()
    
    @IBAction func workoutAddButton(_ sender: Any) {
        //Add workouts here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load sample data
        loadSampleData()
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutTableViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WorkoutTableView")
        self.navigationController?.pushViewController(workoutTableViewController, animated: false)
    }
    
    private func loadSampleData() {
        
        guard let newWorkout1 = Workout(name: "Bench", sets:3, reps:5, weight:200) else {
            fatalError("Unable to instantiate workout")
        }
        
        workouts += [newWorkout1]
        self.tableView.reloadData()

        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
