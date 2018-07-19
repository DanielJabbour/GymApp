//
//  MuscleTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-06-23.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class MuscleTableViewController: UITableViewController {
    
    var muscles = [Muscle]()
    
    @IBAction func addButtonAction(_ sender: Any) {
        addItem()
        self.reloadInputViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Programatically configuring navigation components (title, left, right buttons)
        
        navigationItem.title = "Muscle groups"
        
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
//
//    //Override to support rearranging the table view.
//    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        let movedObject = muscles[fromIndexPath.row]
//        muscles.remove(at: fromIndexPath.row)
//        muscles.insert(movedObject, at: to.row)
//    }
//
//    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            self.muscles.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    private func addItem() {
        
        //Create alert controller
        let alert = UIAlertController(title: "Add a Muscle Group", message: "Enter a new muscle group", preferredStyle: .alert)
        
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
            
            self.muscles += [newMuscle]
            print ("Text field: \(textField!)")
            print (self.muscles)
            self.tableView.reloadData()

        }))
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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


