//
//  DataTableViewCell.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-02.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit
import SwiftChart
import Charts

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //        self.contentView.addSubview(lineChart!)
    //        self.selectionStyle = UITableViewCellSelectionStyle.none
   

}
