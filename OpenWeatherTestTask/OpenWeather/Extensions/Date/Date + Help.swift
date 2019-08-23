//
//  Date + Help.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import Foundation

extension Date {
    
    func dayRepresentation() -> String {
        
        let calendar: Calendar = SMDateService.shared.calendar
        let weekDays: [String] = SMDateService.shared.calendar.weekdaySymbols
        
        let result: String = calendar.isDateInToday(self) ? "Today".localize() : weekDays[calendar.component(.weekday, from: self) - 1]
        
        return result.uppercased()
    }
}
