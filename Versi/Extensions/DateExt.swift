//
//  Date+toString.swift
//  Versi
//
//  Created by nag on 22/09/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import Foundation

extension Date {
    func today() -> String {
        let date = Calendar.current.date(byAdding: .day, value: 0, to: self)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}

