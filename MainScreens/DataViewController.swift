//
//  DataViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-02.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import Charts

class DataViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChartView!
    var lineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadChart()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadChart() {
        
        let value1 = ChartDataEntry(x: 1, y: 1)
        let value2 = ChartDataEntry(x: 2, y: 2)
        let value3 = ChartDataEntry(x: 3, y: 3)
        let value4 = ChartDataEntry(x: 4, y: 4)
        let value5 = ChartDataEntry(x: 5, y: 5)
        
        lineChartEntry.append(value1)
        lineChartEntry.append(value2)
        lineChartEntry.append(value3)
        lineChartEntry.append(value4)
        lineChartEntry.append(value5)
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        
        line1.colors = [NSUIColor.blue]
        let data = LineChartData()
        data.addDataSet(line1)
        
        lineChart.data = data
        lineChart.chartDescription?.text = "LineChart"
        lineChart.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
