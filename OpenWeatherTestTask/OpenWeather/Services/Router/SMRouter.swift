//
//  SMAppManager.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit

class SMRouter {
    
    static let shared: SMRouter = SMRouter()
    
    let route: SMRoute = SMRoute(window: UIApplication.shared.delegate!.window!!) // swiftlint:disable:this force_unwrapping
}

extension SMRoute {
    
    func switchToHome() {
        
        let vc: SMMainTabbarViewController = SMMainTabbarViewController()
        switchTo(vc: vc)
    }
}
