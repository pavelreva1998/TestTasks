//
//  SMForecastPresenter.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import VRGSoftSwiftIOSKit
import CoreLocation

final class SMForecastPresenter: SMBaseModuleListPresenter {
    
    var lon: Double? = SMLocationService.shared.currentLocation?.coordinate.longitude
    var lat: Double? = SMLocationService.shared.currentLocation?.coordinate.latitude

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SMLocationService.shared.currentLocationWithCallback { [weak self] (location, _) in // swiftlint:disable:this explicit_type_interface
            
            if let location: CLLocation = location {
                
                if self?.lon != location.coordinate.longitude || self?.lat != location.coordinate.latitude {
                    
                    self?.lon = location.coordinate.longitude
                    self?.lat = location.coordinate.latitude
                    
                    self?.moduleList?.reloadData()
                }
            }
        }
    }
    
    
    // MARK: Base Overrides
    
    override func defaultFetcher() -> SMDataFetcherProtocol? {
        
        if let lon: Double = lon, let lat: Double = lat {
            
            return SMFetcherWithRequestBlock(requestBlock: { _ -> SMRequest? in
                
                return SMWeatherGateway.shared.getForecast(lat: lat, lon: lon)
            })
        } else {
            
            return nil
        }
    }
    
    override func moduleList(_ aModule: SMModuleList, processFetchedModelsInResponse aResponse: SMResponse) -> [AnyObject] {
        
        var result: [AnyObject] = []
        
        if let weatherList: [SMWeather] = aResponse.boArray as? [SMWeather] {
            
            let dict: Dictionary = Dictionary(grouping: weatherList) { $0.day }
            let sortedKeys: [Date] = dict.keys.sorted { $0 < $1 }
            
            sortedKeys.forEach { key in
                
                if let value: [SMWeather] = dict[key] {
                    
                    result.append(value as AnyObject)
                }
            }
        }
        
        return result
    }
}
