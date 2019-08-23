//
//  String+Url.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import Foundation

extension String {
    
    var url: URL? {
        
        return URL(string: self)
    }
}
