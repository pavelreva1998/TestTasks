//
//  UIImageView + Help.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setTintedImage(withName name: String) {
        
        let image: UIImage? = UIImage(named: name)?.sm_tintedImageWith(color: #colorLiteral(red: 1, green: 0.5490196078, blue: 0.3450980392, alpha: 1))
        
        self.image = image
    }
}
