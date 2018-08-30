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
    
    var lineChart = [LineChartData]()
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
        
        //let data = lineChart[indexPath.row]
        
        //Read through
        cell.lineChart.setLineChartData(xValues: xVals[0], yValues: yVals[0], label: "")
        
        //cell.lineChart.data = data
        cell.lineChart.chartDescription?.text = "Chest"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        cell.lineChart.notifyDataSetChanged()
        
        return cell
    }
    
 
    // MARK: - Data configuration methods
    
    private func makeData(muscleGroup: String) {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").child(muscleGroup).child("Workouts").observe(.value, with: { DataSnapshot in
            
            guard let muscleGroups = DataSnapshot.value as? [String:AnyObject] else {
                return
            }
            
            //TO DO: Change Int for weights to double
            
            var dataPointsY = [Double]()
            var dataPointsX = [String]()
            var aggregatePointsDict = [String:Double]()
            
            struct data {
                let date: String
                let value: Double
            }
            
            var dataArr = [data]()
            
            for (key, value) in muscleGroups {
                
                if (key != "Dummy") {
                    
                    let repsVal = value["Reps"] as! Double
                    let setsVal = value["Sets"] as! Double
                    let weightVal = value["Weight"] as! Double
                    let dateVal = value["Date"] as! String
                    
                    let cumulitiveVal = repsVal*setsVal*weightVal
                    
                    //print (cumulitiveVal, dateVal)
                    
                    dataArr.append(data(date: dateVal, value: cumulitiveVal))
                    
                    aggregatePointsDict[dateVal] = (aggregatePointsDict[dateVal] ?? 0) + cumulitiveVal
                    
                }
            }
            
            //Add additional key dictating order. Make your DS = Dictionary(key: order, value: Dictionary(key:dates, value: aggPoints)
            
            
            //Order gets messed up in dict
            //print (aggregatePointsDict)
            
            for index in 0...dataArr.count - 1 {
                print(dataArr[index].date, dataArr[index].value)
                dataPointsX.append(dataArr[index].date)
                dataPointsY.append(dataArr[index].value)
            }

            //Append appropriate data points
//            for item in aggregatePointsDict {
//                dataPointsX.append(item.key)
//                dataPointsY.append(item.value)
//            }
            
            //print(dataPointsY)
            //print(dataPointsX)
            
            self.xVals.append(dataPointsX.reversed())
            self.yVals.append(dataPointsY.reversed())
            
            
        })
        
    }
    
    
    private func getMuscleGroupCount() {
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            self.groupCount = Int(DataSnapshot.childrenCount)
            self.tableView.reloadData()
        }
    }

    
}
