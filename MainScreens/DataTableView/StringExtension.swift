//
//  StringExtension.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-09-20.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import Foundation

extension String {
    static let shortDateUS: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateStyle = .short
        return formatter
    }()
    var shortDateUS: Date? {
        return String.shortDateUS.date(from: self)
    }
}
