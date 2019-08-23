//
//  SMForecastCell.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.


import VRGSoftSwiftIOSKit

class SMForecastCellData: SMCellData {
    
    required init(model aModel: AnyObject?) {
        
        super.init(model: aModel)
        
        cellNibName = String(describing: SMForecastCell.self)
        cellHeight = 110
        cellSelectionStyle = .none
        cellSeparatorInset = UIEdgeInsets(top: 0, left: 116.5, bottom: 0, right: 0)
    }
}

class SMForecastCell: SMCell {
 
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbDegrees: UILabel!
    
    
    // MARK: Base Overrides
    
    override func setupCellData(_ aCellData: SMListCellData) {
        
        super.setupCellData(aCellData)
        
        if let model: SMWeather = cellData?.model as? SMWeather {
            
            ivWeather.setTintedImage(withName: model.rawIcon ?? "")
            lbTime.text = model.time
            lbDescription.text = model.skyState
            lbDegrees.text = model.formattedTemperature
        }
    }
}
