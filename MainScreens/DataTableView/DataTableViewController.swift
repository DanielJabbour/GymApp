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
    
    //TO DO: CHANGE X AXIS FROM DATES TO NUMBERS
    var lineDataEntry: [[ChartDataEntry]] = []
    
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
        
        //Method to retrieve muscle group data
        getGroupData()

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
        
        //Uncomment this line and comment out the lines between MARK1 & MARK2 to change x-axis to dates
//        cell.lineChart.setLineChartData(xValues: xVals[indexPath.row], yValues: yVals[indexPath.row], label: "")
        
        //MARK-1
        var dataPoint = [ChartDataEntry]()
        
        for index in 0...yVals.count - 1{
            for index2 in 0...yVals[index].count - 1{
                dataPoint.append(ChartDataEntry(x: Double(index2 + 1), y: Double(yVals[index][index2])))
            }
            lineDataEntry.append(dataPoint)
            dataPoint.removeAll()
        }
        
        var muscleGroupsArr = [String]()
        for (key, _) in self.muscleGroupsOld {
            if key != "Dummy" {
                muscleGroupsArr.append(key)
            }
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry[indexPath.row], label: muscleGroupsArr[indexPath.row])
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        
        //Data Set Color Customization
        chartDataSet.colors = [UIColor.cyan]
        chartDataSet.setCircleColor(UIColor.cyan) //0, 178, 202
        chartDataSet.circleHoleColor = UIColor.cyan
        chartDataSet.circleHoleRadius = 4.0
        
        //Color Gradient Definition
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("Gradient Error"); return cell}
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 0.0)
        chartDataSet.drawFilledEnabled = true
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.circleRadius = 3.0
        chartDataSet.valueTextColor = NSUIColor.cyan
        
        //MARK-2
        
        //All other additions to this function will go here
        cell.lineChart.xAxis.labelPosition = .bottom
        cell.lineChart.xAxis.drawGridLinesEnabled = false
        cell.lineChart.chartDescription?.enabled = false
        //cell.lineChart.legend.enabled = false -- Uncomment this for disabling the bottom label
        cell.lineChart.rightAxis.enabled = false
        cell.lineChart.leftAxis.drawGridLinesEnabled = false
        cell.lineChart.leftAxis.drawLabelsEnabled = true
        cell.lineChart.backgroundColor = UIColor.black
        cell.lineChart.xAxis.labelTextColor = UIColor.cyan //Axis colors
        cell.lineChart.leftAxis.labelTextColor = UIColor.cyan
        cell.lineChart.legend.textColor = UIColor.cyan //Legend color
        
        cell.lineChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
        //Axes setup ... FIX THIS
        cell.lineChart.setVisibleXRangeMaximum(Double(yVals[indexPath.row].count + 1))
        cell.lineChart.setVisibleXRangeMinimum(1.0)
        
        //Add data to view
        cell.lineChart.data = chartData
        
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

}
