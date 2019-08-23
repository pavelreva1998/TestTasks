//
//  SMBaseModelTableViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit


class SMBaseModelTableViewController: SMBaseTableViewController, SMBaseModuleListPresenterProtocol, SMListAdapterDelegate, SMListDisposerModeledDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        (presenter as? SMBaseModuleListPresenter)?.setupListAdapter(createListAdapter())
    }
    
    override func createListDisposer() -> SMListDisposer {
        
        let result: SMTableDisposerModeled = SMTableDisposerModeled()
        
        result.modeledDelegate = self
        
        return result
    }
    
    func createListAdapter() -> SMListAdapter {
        
        guard let tableDisposer: SMTableDisposerModeled = tableDisposer as? SMTableDisposerModeled else {
            
            assert(true, #function + " collectionDisposer is not SMCollectionDisposerModeled class")
            return SMTableAdapter(listDisposer: SMTableDisposerModeled())
        }
        
        let result: SMTableAdapter = SMTableAdapter(listDisposer: tableDisposer)
        
        result.delegate = self
        
        return result
    }
    
    
    // MARK: SMListAdapterDelegate
    
    func listAdapter(_ aListAdapter: SMListAdapter, sectionForModels aModels: [AnyObject], indexOfSection aIndex: Int) -> SMListSection? {
       
        return nil
    }
    
    func listDisposer(_ aListDisposer: SMListDisposer, cellDataClassForUnregisteredModel aModel: AnyObject) -> SMListCellData.Type {
        
        return SMListCellData.self
    }

    func defaultSectionForlistAdapter(_ aListAdapter: SMListAdapter) -> SMListSection? {
        
        return SMSectionReadonly()
    }
    
    func prepareSectionsFor(listAdapter aListAdapter: SMListAdapter) {
        
        tableDisposer?.sections.removeAll()
    }
    
    func moreCellDataForListAdapter(_ aListAdapter: SMListAdapter) -> SMPagingMoreCellDataProtocol? {
        
        //TODO: Need add morecelldata
        return nil
    }
    
    func listAdapter(_ aListAdapter: SMListAdapter, needAddModels aModels: [AnyObject], toSection aSection: SMListSection, withLastModel aLastModel: AnyObject) -> Bool {
        return true
    }
}
