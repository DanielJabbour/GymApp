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
    
    var name: String
    var sets: Int
    var reps: Int
    var weight: Int
    
    //Initializer method
    init?(name: String, sets: Int, reps: Int, weight: Int) {
        
        //guard only allows further code to be executed if it's true
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        
    }
}
