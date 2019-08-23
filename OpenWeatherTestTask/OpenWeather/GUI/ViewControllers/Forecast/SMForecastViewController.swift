//
//  SMForecastViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.


import VRGSoftSwiftIOSKit

final class SMForecastViewController: SMBaseModelTableViewController {
    
    override func createPresenter() -> SMBasePresenter {
        
        let result: SMForecastPresenter = SMForecastPresenter(vc: self)
        
        return result
    }
    
    var custPresenter: SMForecastPresenter? {
        
        return presenter as? SMForecastPresenter
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        prepareLocalization()
    }
    
    
    // MARK: Base Overrides
    
    override func configureListDisposer() {
        
        super.configureListDisposer()
        
        guard let modeledTableDisposer: SMTableDisposerModeled = listDisposer as? SMTableDisposerModeled else { return }
        
        modeledTableDisposer.register(cellDataClass: SMForecastCellData.self, forModelClass: SMWeather.self)
    }
    
    override func listAdapter(_ aListAdapter: SMListAdapter, needAddModels aModels: [AnyObject], toSection aSection: SMListSection, withLastModel aLastModel: AnyObject) -> Bool {
        
        return false
    }
    
    override func listAdapter(_ aListAdapter: SMListAdapter, sectionForModels aModels: [AnyObject], indexOfSection aIndex: Int) -> SMListSection? {
        
        let result: SMSectionReadonly = SMSectionReadonly()
        
        let headerView: SMForecastHeaderView = SMForecastHeaderView.loadFromNib()
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let day: String = (aModels.first as? SMWeather)?.day.dayRepresentation() {
            
            headerView.setupWithTitle(day)
        }
        
        result.headerView = headerView
        
        return result
    }

    
    // MARK: Localization
    
    override func prepareLocalization() {
        
        title = "Forecast".localize()
    }
}
