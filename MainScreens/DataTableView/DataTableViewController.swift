//
//  DataTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-02.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import SwiftChart
import Firebase
import FirebaseDatabase

class DataTableViewController: UITableViewController {
    
    var charts = [Chart]()
    var ref: DatabaseReference!
    let email = UserDefaults.standard.object(forKey: "UserEmail") as! String
    let userID = UserDefaults.standard.object(forKey: "UserID") as! String
    var groupCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //Method to retrieve count of muscle groups in order to determine the number of required rows
        getMuscleGroupCount()
        
        //Method to make data
        makeData(muscleGroup: "Chest")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.groupCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataTableViewCell else {
            fatalError("The dequed cell is not an instance of DataTableViewCell")
        }
        
        //TO DO: Read data from database to display on charts. X-axis = session #s OR weeks, Y-axis = cumulative score (sets x reps x weight)
        
        let chart = Chart(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])
        chart.add(series)
        
        let chart2 = Chart(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        let series2 = ChartSeries([0, 5, 3, 19, 3, 1, -1, 10, 8])
        chart2.add(series2)

        
        charts += [chart]
        charts += [chart2]
        
        cell.contentView.addSubview(charts[indexPath.row])
        return cell
    }
 
    // MARK: - Data configuration methods
    
    private func makeData(muscleGroup: String) {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").child(muscleGroup).child("Workouts").observe(.value, with: { DataSnapshot in
            
            guard let muscleGroups = DataSnapshot.value as? [String:AnyObject] else {
                return
            }
            
            //TO DO: Change Int for weights to double
            
            //let chart = Chart(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            var dataPointsX = [Int]()
            var dataPointsY = [String]()
            var pointsDict = [String:Int]()
            var aggregatePointsDict = [String:Int]()
            
            for (key, value) in muscleGroups {
                
                if (key != "Dummy") {
                    
                    //Need to match all points with same dates to get cumulitive date
                    // For all values on date X, sum(prod(workout))
                    
                    let repsVal = value["Reps"] as! Int
                    let setsVal = value["Sets"] as! Int
                    let weightVal = value["Weight"] as! Int
                    let dateVal = value["Date"] as! String
                    
                    let cumulitiveVal = repsVal*setsVal*weightVal
                    
                    //Add data points to array correspondingly
                    
                    pointsDict[dateVal] = cumulitiveVal
                    
                    for item in pointsDict {
                        aggregatePointsDict[item.key] = (aggregatePointsDict[item.key] ?? 0) + item.value
                    }
                    
                }
            }
            
            print(aggregatePointsDict)
            
        })
    }
    
    private func getMuscleGroupCount() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            self.groupCount = Int(DataSnapshot.childrenCount)
            self.tableView.reloadData()
        }
    }
    
    
    
}
