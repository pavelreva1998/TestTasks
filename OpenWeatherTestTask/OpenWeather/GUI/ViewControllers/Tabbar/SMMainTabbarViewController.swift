//
//  SMMainTabbarViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/28/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit

class SMMainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        prepareTabBar()
    }
    
    func prepareTabBar() {
        
        tabBar.backgroundImage = UIImage()
        
        var controllers: [UIViewController] = []
        
        do {
            
            let vc: SMBaseViewController = SMCurrentWeatherViewController()
            controllers.append(createTabItem(vc: vc, image: UIImage(named: "ic_today"), title: "Today".localize()))
        }
        
        do {
            
            let vc: SMBaseViewController = SMForecastViewController()
            controllers.append(createTabItem(vc: vc, image: UIImage(named: "ic_forecast"), title: "Forecast".localize()))
        }
        
        viewControllers = controllers
        
        tabBar.isTranslucent = false
    }
    
    func createTabItem(vc aVc: SMBaseViewController, image aImage: UIImage?, title: String?) -> UINavigationController {
        
        let normalImage: UIImage? = aImage?.withRenderingMode(.alwaysOriginal)
        let selectedImage: UIImage? = normalImage?.sm_tintedImageWith(color: #colorLiteral(red: 0, green: 0.568627451, blue: 0.9764705882, alpha: 1))?.withRenderingMode(.alwaysOriginal)
        
        let vc: SMBaseViewController = aVc

        let nc: UINavigationController = UINavigationController(rootViewController: vc)
        
        let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        
        nc.tabBarItem = tabBarItem
        
        return nc
    }
}
