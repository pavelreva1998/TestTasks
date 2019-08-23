//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/28/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        configureGateways()
        
        SMLocationService.shared.startUpdatingLocation()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        SMRouter.shared.route.switchToHome()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureGateways() {
        
        SMGatewayConfigurator.shared.register(gateway: SMWeatherGateway.shared)
        SMGatewayConfigurator.shared.configureGatewaysWithBase(url: SMAppConfig.baseUrl.url!) // swiftlint:disable:this force_unwrapping
    }
}
