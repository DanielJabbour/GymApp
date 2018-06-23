//
//  Muscle.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-06-23.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class Muscle {
    
    var group: String
    
    //Initializer method
    init?(group: String) {
        
        //guard only allows further code to be executed if it's true
        guard !group.isEmpty else {
            return nil
        }
        
        self.group = group
        
    }
}
