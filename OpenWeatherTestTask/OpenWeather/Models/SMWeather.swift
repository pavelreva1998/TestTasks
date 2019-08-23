//
//  WeatherItem.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import VRGSoftSwiftIOSKit

class SMWeather: NSObject {

    var rawIcon: String?
    var skyState: String?
    var temperature: Double?
    var humidity: Int?
    var pressure: Int?
    var windSpeed: Double?
    
    var city: String?
    var countryCode: String?
    
    var date: Date?
    var rawDay: String?
    
    var time: String?
    
    var formattedTemperature: String {
        
        var result: String = ""
        
        if let temperature: Double = temperature {
            
            result = "\(Int(temperature))°"
        }
        
        return result
    }
    
    var formatterTemperatureCellsium: String {
        
        let result: String = formattedTemperature + "C"
        
        return result
    }
    
    var formattedHumidity: String {
        
        var result: String = ""
        
        if let humidity: Int = humidity {
            
            result = "\(humidity)%"
        }
        
        return result
    }
    
    var formattedPressure: String {
        
        var result: String = ""
        
        if let pressure: Int = pressure {
            
            result = "\(pressure) hPA"
        }
        
        return result
    }
    
    var formattedWindSpeed: String {
        
        var result: String = ""
        
        if let windSpeed: Double = windSpeed {
            
            result = "\(Int(windSpeed)) km/h"
        }
        
        return result
    }
    
    var formattedLocation: String {
        
        var result: String = ""
        
        if let city: String = city, let countryCode: String = countryCode {
            
            result = "\(city), \(countryCode)"
        }
        
        return result
    }
    
    var day: Date {
        
        var result: Date = Date()
        
        if let dayStr: String = rawDay, let date: Date = SMDateService.shared.convert(string: dayStr, withFormat: .yyyyMMdd, isUTC: false) {
            
            result = date
        }
        
        return result
    }
 
    override var description: String {
        
        let result: String = String(format: "shared_text".localize(), city ?? "", formattedTemperature, formattedPressure, formattedHumidity)
        
        return result
    }
    
    init(withData aData: [String: Any]) {
        
        if let weatherArray: [[String: Any]] = aData["weather"] as? [[String: Any]] {
            
            if let weather: [String: Any] = weatherArray.first {
                
                rawIcon = weather["icon"] as? String
                skyState = weather["main"] as? String
            }
        }
        
        if let temperature: Double = aData.value(forKeyPath: "main.temp") as? Double {
            
            self.temperature = temperature - Double(SMAppConfig.kelnivToCelsium)
        }
        
        humidity = aData.value(forKeyPath: "main.humidity") as? Int
        pressure = aData.value(forKeyPath: "main.pressure") as? Int
        windSpeed = aData.value(forKeyPath: "wind.speed") as? Double
        city = aData["name"] as? String
        countryCode = aData.value(forKeyPath: "sys.country") as? String
        
        if let timestamp: Int = aData["dt"] as? Int {
            
            date = Date(timeIntervalSince1970: TimeInterval(timestamp))
            
            if let date: Date = date {
                
                rawDay = SMDateService.shared.convert(date: date, withFormat: .yyyyMMdd, isUTC: false)
                time = SMDateService.shared.convert(date: date, withFormat: .HHmm, isUTC: false)
            }
        }
    }
}
