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
    
    var xVals = [[String]]()
    var yVals = [[Double]]()
    var muscleGroupsOld = [String:AnyObject]()
    var muscleGroupsNew = [String]()
    
    var ref: DatabaseReference!
    let email = UserDefaults.standard.object(forKey: "UserEmail") as! String
    let userID = UserDefaults.standard.object(forKey: "UserID") as! String
    var groupCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        
        //Method to retrieve count of muscle groups in order to determine the number of required rows
        getMuscleGroupCount()
        
        getGroupData()
        
        
//        makeData(muscleGroup: "Chest")
//        makeData(muscleGroup: "Triceps")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
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
        
        //Read through ... Index out of range?
        cell.lineChart.setLineChartData(xValues: xVals[indexPath.row], yValues: yVals[indexPath.row], label: "")
        
        //cell.lineChart.data = data
        cell.lineChart.chartDescription?.text = "Chest"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        cell.lineChart.notifyDataSetChanged()
        
        return cell
    }
    
 
    // MARK: - Data configuration methods
    
    private func getGroupData() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value, with: { DataSnapshot in
            
            guard let muscleGroups = DataSnapshot.value as? [String:AnyObject] else {
                return
            }
            
            self.muscleGroupsOld = muscleGroups
            
            //Potential solution: Read muscle groups old, strip all integers, make all values unique, then process
            //Random crash?
            for (key, _) in muscleGroups {
                self.processData(muscleGroup: key)
            }

        })
    }
    
    private func processData(muscleGroup: String) {
        //TO DO: Change Int for weights to double when pushed to db
        
        var dataPointsY = [Double]()
        var dataPointsX = [String]()
        var aggregatePointsDict = [String:Double]()
        
        struct data {
            let date: String
            let value: Double
        }
        
        //nil
        let workouts = self.muscleGroupsOld[muscleGroup] as! [String:AnyObject]
        let muscleGroups = workouts["Workouts"] as! [String:AnyObject]
        
        var dataArr = [data]()
        
        for (key, value) in muscleGroups {
            
            if (key != "Dummy") {
                
                let repsVal = value["Reps"] as! Double
                let setsVal = value["Sets"] as! Double
                let weightVal = value["Weight"] as! Double
                let dateVal = value["Date"] as! String
                
                let cumulitiveVal = repsVal*setsVal*weightVal
                
                dataArr.append(data(date: dateVal, value: cumulitiveVal))
                
                aggregatePointsDict[dateVal] = (aggregatePointsDict[dateVal] ?? 0) + cumulitiveVal
                
            }
        }
        
        //Order gets messed up in dict
        
        for index in 0...dataArr.count - 1 {
            let currentDate = dataArr[index].date
            var currentVal = dataArr[index].value
            
            if (currentVal != aggregatePointsDict[currentDate]){
                currentVal = aggregatePointsDict[currentDate]!
            }
            
            dataPointsX.append(currentDate)
            dataPointsY.append(currentVal)
        }
        
        //Need to eliminate duplicates
        let groupedDataX = dataPointsX.removingDuplicates()
        let groupedDataY = dataPointsY.removingDuplicates()
        
        //Reverse array to maintain order from earliest to latest date
        self.xVals.append(groupedDataX.reversed())
        self.yVals.append(groupedDataY.reversed())
    }
    
    
    
    private func getMuscleGroupCount() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            self.groupCount = Int(DataSnapshot.childrenCount)
            self.tableView.reloadData()
        }
    }
    
    private func getMuscleGroups() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            
            guard let muscleGroups = DataSnapshot.value as? [String:AnyObject] else {
                return
            }
            
        }
    }
    
}
