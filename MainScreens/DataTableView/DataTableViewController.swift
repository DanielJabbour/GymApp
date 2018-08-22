//
//  DataTableViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-02.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseDatabase

class DataTableViewController: UITableViewController {
    
    var barChart = [BarChartData]()
    
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
        
        //testing
        makeBarData()
        
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
        
        return self.groupCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataTableViewCell else {
            fatalError("The dequed cell is not an instance of DataTableViewCell")
        }
        
        //TO DO: Read data from database to display on charts. X-axis = session #s OR weeks, Y-axis = cumulative score (sets x reps x weight)
        
        let data = barChart[indexPath.row]
        
        cell.barChart.data = data
        cell.barChart.chartDescription?.text = "Number of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        cell.barChart.notifyDataSetChanged()
        
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
                    
                    aggregatePointsDict[dateVal] = (aggregatePointsDict[dateVal] ?? 0) + cumulitiveVal
                }
            }

            //Append appropriate data points
            for item in aggregatePointsDict {
                dataPointsY.append(item.key)
                dataPointsX.append(item.value)
            }
            
        })
        
    }
    
    private func getMuscleGroupCount() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            self.groupCount = Int(DataSnapshot.childrenCount)
            self.tableView.reloadData()
        }
    }
    
    private func makeBarData() {
        let entry1 = BarChartDataEntry(x: 1.0, y: 1.0)
        let entry2 = BarChartDataEntry(x: 2.0, y: 2.0)
        let entry3 = BarChartDataEntry(x: 3.0, y: 3.0)
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let dataToPass = BarChartData(dataSets: [dataSet])
        
        let entry4 = BarChartDataEntry(x: 5.0, y: 1.0)
        let entry5 = BarChartDataEntry(x: 4.0, y: 2.0)
        let entry6 = BarChartDataEntry(x: 3.0, y: 3.0)
        let dataSet2 = BarChartDataSet(values: [entry4, entry5, entry6], label: "Widgets 2")
        let dataToPass2 = BarChartData(dataSets: [dataSet2])
        
        barChart += [dataToPass]
        barChart += [dataToPass2]
        
    }

    
    
}
