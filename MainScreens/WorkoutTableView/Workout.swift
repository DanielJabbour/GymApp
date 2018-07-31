//
//  Workout.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-07-31.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import Foundation
import UIKit

class Workout {
    
    var group: String
    var sets: Int
    var Repetitions: Int
    
    //Initializer method
    init?(group: String, sets: Int, Repetitions: Int) {
        
        //guard only allows further code to be executed if it's true
        guard !group.isEmpty else {
            return nil
        }
        
        self.group = group
        self.sets = sets
        self.Repetitions = Repetitions
        
    }
}
