//
//  SMBaseTableViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit


protocol SMListMapProtocol {
    
    func mapToObject()
}


class SMBaseTableViewController: SMBaseListViewController, SMTableDisposerDelegate, SMListMapProtocol {
 
    var tableView: UITableView? { return listView as? UITableView }

    var tableDisposer: SMTableDisposer? { return listDisposer as? SMTableDisposer }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if needCreateEmptyView() {
            
            emptyView = createEmptyView()
        }
    }
    
    override func createListView() -> UITableView {
        
        let result: UITableView = UITableView(frame: self.frameListView(), style: .plain)
        
        return result
    }

    override func configureListView() {
        
        super.configureListView()
        
        if let listView: UITableView = listView as? UITableView {
            
            listView.tableHeaderView = createTableViewHeader()
            listView.tableHeaderView?.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]

            listView.tableFooterView = createTableViewFotter()
            listView.tableFooterView?.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]

            listView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override func createListDisposer() -> SMListDisposer? {
        
        let result: SMTableDisposer = SMTableDisposer()
        
        return result
    }
    
    override func configureListDisposer() {
        
        super.configureListDisposer()
        
        tableDisposer?.delegate = self
    }

    func createTableViewHeader() -> UIView? {
        
        return nil
    }
    
    func createTableViewFotter() -> UIView? {
        
        return UIView()
    }
    
    
    // MARK: SMListMapProtocol
    
    func mapToObject() {
        
        if let tableDisposer: SMTableDisposerMapped = tableDisposer as? SMTableDisposerMapped {
            
            tableDisposer.mapToObject()
        }
    }
    
    var emptyView: UIView?
    
    func showEmptyViewIfNeed() {
        
        tableDisposer?.sections.removeAll()
        tableDisposer?.reloadData()
        
        emptyView?.sm_showAnimate(false)
    }
    
    func hideEmptyView(animated: Bool) {
        
        emptyView?.sm_hideAnimate(animated)
    }
    
    func parentEmptyView() -> UIView {
        
        return tableDisposer?.tableView ?? UIView()
    }
    
    func emptyViewFrame() -> CGRect {
        
        return self.parentEmptyView().bounds
    }
    
    func createEmptyView() -> UIView? {
        
        return nil
    }
    
    func needCreateEmptyView() -> Bool {
        
        return false
    }
}
