//
//  SMWeatherGateway.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit
import SwiftyJSON

class SMWeatherGateway: SMBaseGateway {

    static let shared: SMWeatherGateway = SMWeatherGateway()
    
    func getCurrentWeather(lat: Double, lon: Double) -> SMGatewayRequest {
        
        var params: [String: AnyObject] = [:]
        params["lat"] = lat as AnyObject
        params["lon"] = lon as AnyObject
        params["appid"] = SMAppConfig.apiKey as AnyObject
        
        let request: SMGatewayRequest = self.request(type: .get, path: "weather", parameters: params) { _, response -> SMResponse in
            
            let result: (SMResponse, JSON) = response.defaultResult()
            
            if result.0.isSuccess {
                
                if let object: Any = result.1.dictionaryObject {
                    
                    result.0.dataDictionary = object as? [String: AnyObject] ?? [:]
                }
            }
            
            return result.0
        }
        
        return request
    }
    
    func getForecast(lat: Double, lon: Double) -> SMGatewayRequest {
        
        var params: [String: AnyObject] = [:]
        params["lat"] = lat as AnyObject
        params["lon"] = lon as AnyObject
        params["appid"] = SMAppConfig.apiKey as AnyObject
        
        let request: SMGatewayRequest = self.request(type: .get, path: "forecast", parameters: params) { _, response -> SMResponse in
            
            let result: (SMResponse, JSON) = response.defaultResult()
            
            if result.0.isSuccess {
                
                if let object: [String: Any] = result.1.dictionaryObject {
                    
                    if let weatherList: [[String: Any]] = object["list"] as? [[String: Any]] {
                        
                        result.0.boArray = weatherList.compactMap { SMWeather(withData: $0) }
                    }
                }
            }
            
            return result.0
        }
        
        return request
    }
}
