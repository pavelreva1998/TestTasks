//
//  SMCurrentWeatherPresenter.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import VRGSoftSwiftIOSKit
import CoreLocation
import Firebase

protocol SMCurrentWeatherPresenterProtocol {
    
    func updateWithWeather(_ weather: SMWeather)
    func showErrorAlert()
}

final class SMCurrentWeatherPresenter: SMBasePresenter {
    
    var ref: DatabaseReference!

    var custViewController: SMCurrentWeatherPresenterProtocol? {
        
        return vc as? SMCurrentWeatherPresenterProtocol
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        getDataFromDatabase()
        
        AuthService.shared.checkAuthStatus { result in
            if result {
                SMLocationService.shared.currentLocationWithCallback { [weak self] location, error in // swiftlint:disable:this explicit_type_interface
                    
                    if error != nil {
                        
                        self?.custViewController?.showErrorAlert()
                    } else if let location: CLLocation = location {
                
                        self?.getDataFromApi(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
                    }
                }
            }
        }
    }
    
    private func getDataFromDatabase() {
        
        if let userId: String = AuthService.shared.userID {
            
            SMWeatherDataBaseGateway.shared.getWeatherForUserID(userID: userId, completion: { [weak self] result in // swiftlint:disable:this explicit_type_interface
                if let result: [String: Any] = result as? [String: Any] {
                    
                    if !result.isEmpty {
                        
                        let weather: SMWeather = SMWeather(withData: result)
                        self?.custViewController?.updateWithWeather(weather)
                    }
                }
            })
        }
    }
    
    private func getDataFromApi(longitude: Double, latitude: Double) {
        
        let request: SMGatewayRequest = SMWeatherGateway.shared.getCurrentWeather(lat: latitude, lon: longitude)

        apply(request: request, needActivity: false, responseBlock: { [weak self] response in // swiftlint:disable:this explicit_type_interface
            
            if let userID: String = AuthService.shared.userID {
                
                SMWeatherDataBaseGateway.shared.setWeatherData(response.dataDictionary, for: userID)
                
                let weather: SMWeather = SMWeather(withData: response.dataDictionary)
                self?.custViewController?.updateWithWeather(weather)
            }
        })
    }
}
