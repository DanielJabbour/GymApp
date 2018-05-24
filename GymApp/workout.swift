//
//  workout.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-05-21.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class workout {
    
    //workout class properties
    var title: String
    var reps: Int
    var sets: Int
    
    //Constructor
    init?(title: String, reps: Int, sets: Int){
        
        //Need to add error handling for false values
        
        self.title = title
        self.reps = reps
        self.sets = sets
        
    }
    
    
}
