//
//  LineChartFormatter.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-30.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import Foundation
import Charts

extension LineChartView {
    
    private class LineChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    
    }
    
    func setLineChartData(xValues: [String], yValues: [Double], label: String) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: label)
        let chartData = LineChartData(dataSet: chartDataSet)
        
        //Data Set Color Customization
        chartDataSet.colors = [UIColor.magenta]
        chartDataSet.setCircleColor(UIColor.magenta)
        chartDataSet.circleHoleColor = UIColor.magenta
        chartDataSet.circleHoleRadius = 4.0
        
        //Color Gradient Definition
        let gradientColors = [UIColor.magenta.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("Gradient Error"); return}
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        let chartFormatter = LineChartFormatter(labels: xValues)
        let xAxis = XAxis()
        
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
    }
    
}
