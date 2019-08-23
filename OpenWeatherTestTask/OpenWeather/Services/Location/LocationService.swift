//
//  LocationService.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import CoreLocation

typealias SMLocationServiceCallback = (_ aLocation: CLLocation?, _ aError: Error?) -> Void

protocol SMLocationServiceDelegate: class {
    
    func locationService(_ aLocationService: SMLocationService, didChangeLocation aLocation: CLLocation)
    func locationService(_ aLocationService: SMLocationService, didChangeAuthorization status: CLAuthorizationStatus)
}

class SMLocationService: NSObject {
    
    static let shared: SMLocationService = SMLocationService()
    
    var currentLocation: CLLocation?
    let multicatstDelegate: MulticastDelegate<SMLocationServiceDelegate> = MulticastDelegate(options: NSPointerFunctions.Options.weakMemory) // swiftlint:disable:this weak_delegate
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var callbacks: [SMLocationServiceCallback] = []
    
    override init() {
        
        super.init()
        
        setup()
    }
    
    func startUpdatingLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocation() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            
            locationManager.requestLocation()
        }
    }
    
    func currentLocationWithCallback(_ aCallBack: @escaping SMLocationServiceCallback) {
        
        if let currentLocation: CLLocation = currentLocation {
            
            aCallBack(currentLocation, nil)
        } else {
            
            callbacks.append(aCallBack)
            requestLocation()
        }
    }
    
    private func sendCallBacksWith(location aLocation: CLLocation?, error aError: Error?) {
       
        for callback: SMLocationServiceCallback in callbacks {
            
            callback(aLocation, aError)
        }
        
        callbacks.removeAll()
    }
    
    private func setup() {
        
        locationManager.delegate = self
        locationManager.distanceFilter = 20
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
}


extension SMLocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        currentLocation = locations.last
        
        multicatstDelegate.invokeDelegates { delegate in
            
            if let location: CLLocation = locations.last {
                delegate.locationService(self, didChangeLocation: location)
            }
        }
        
        sendCallBacksWith(location: locations.last, error: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        sendCallBacksWith(location: nil, error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        multicatstDelegate.invokeDelegates { delegate in
            
            delegate.locationService(self, didChangeAuthorization: status)
        }
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            requestLocation()
        }
    }
}
