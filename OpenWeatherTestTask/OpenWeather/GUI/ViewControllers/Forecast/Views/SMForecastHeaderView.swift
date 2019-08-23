//
//  SMForecastHeaderView.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.


import UIKit

class SMForecastHeaderView: UIView {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    func setupWithTitle(_ title: String?) {
        
        lbTitle.text = title
    }
}
