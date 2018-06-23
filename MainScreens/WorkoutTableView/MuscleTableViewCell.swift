//
//  MuscleTableViewCell.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-06-22.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class MuscleTableViewCell: UITableViewCell {

    @IBOutlet weak var WorkoutName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
