//
//  ArrayExtension.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-08-30.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
