//
//  WorkoutCellTableViewCell.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-05-20.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class WorkoutCellTableViewCell: UITableViewCell {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var setsOutlet: UILabel!
    @IBOutlet weak var repsOutlet: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
