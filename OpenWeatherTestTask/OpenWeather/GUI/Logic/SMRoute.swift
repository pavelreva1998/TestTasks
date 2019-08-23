//
//  SMRoute.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit


class SMRoute {
    
    let window: UIWindow
    
    init(window aWindow: UIWindow) {
        
        window = aWindow
    }
    
    func switchTo(vc aVc: UIViewController) {
        
        let snapShot: UIView? = window.snapshotView(afterScreenUpdates: false)
        if let snapShot: UIView = snapShot {
            
            self.window.addSubview(snapShot)
        }
        
        self.dismiss(vc: aVc) {
            
            self.window.rootViewController = aVc
            
            if let snapShot: UIView = snapShot {
                
                self.window.bringSubviewToFront(snapShot)
                UIView.animate(withDuration: 0.3, animations: {
                    snapShot.layer.opacity = 0
                }, completion: { _ in
                    DispatchQueue.main.async {
                        snapShot.removeFromSuperview()
                    }
                })
            }
        }
    }
    
    func dismiss(vc aVc: UIViewController, completion aCallBack: @escaping (() -> Swift.Void)) {
        
        if aVc.presentedViewController != nil {
            
            self.dismiss(vc: aVc, completion: {
                aVc.dismiss(animated: false, completion: {
                    aCallBack()
                })
            })
        } else {
            
            aCallBack()
        }
    }
}
