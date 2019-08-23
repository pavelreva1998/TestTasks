//
//  SMDateService.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit

enum SMDateFormats: String {
    
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMMddHHmm = "yyyy-MM-dd HH:mm:ss"
    case HHmm = "HH:mm"
}

class SMDateService {

    static let shared: SMDateService = SMDateService()
    
    let calendar: Calendar = Calendar.current
    private let dateFormatter: DateFormatter = DateFormatter()

    func convert(date aDate: Date, withFormat aFormat: SMDateFormats, isUTC: Bool = false) -> String {
        
        dateFormatter.dateFormat = aFormat.rawValue
        dateFormatter.timeZone = isUTC ? TimeZone(secondsFromGMT: 0) : TimeZone.current
        
        let result: String = dateFormatter.string(from: aDate)
        
        return result
    }
    
    func convert(string aString: String, withFormat aFormat: SMDateFormats, isUTC: Bool = false) -> Date? {
        
        dateFormatter.dateFormat = aFormat.rawValue
        dateFormatter.timeZone = isUTC ? TimeZone(secondsFromGMT: 0) : TimeZone.current
        
        let result: Date? = dateFormatter.date(from: aString)
        
        return result
    }
}
