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
        getCount()
        
        print("Hello" + userID)
        
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
        
        //TO DO: Read data from database to display on charts
        
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
    
    private func getCount() {
        
        ref?.child("Users").child(userID).child("MuscleGroupsOld").observe(.value) { DataSnapshot in
            print(DataSnapshot.childrenCount)
            self.groupCount = Int(DataSnapshot.childrenCount)
            
            self.tableView.reloadData()
        }
    }
    
}
