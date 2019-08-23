//
//  SMBasePresenter.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit


enum SMUpdateBehavior {
    
    case reload
    case non
}


class SMBasePresenter: Any {
    
    unowned let vc: SMBaseViewController
    var representObject: Any?
    
    
    // MARK: Init / DeInit
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        print(#function + " - \(type(of: self))")
    }
    
    init(vc aVc: SMBaseViewController) {
        
        vc = aVc
    }
    
    var isNeedReloadWhenAppear: Bool = true
    
    
    // MARK: Life Cycle
    
    open func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    open func viewWillAppear(_ animated: Bool) {
        
        if isNeedReloadWhenAppear {
            
            reloadData()
        }
    }
    
    open func viewDidAppear(_ animated: Bool) {}
    open func viewWillDisappear(_ animated: Bool) {}
    open func viewDidDisappear(_ animated: Bool) {}

    open func close() {}
    
    @objc open func applicationDidEnterBackground() {}
    @objc open func applicationDidBecomeActive() {}

    open func firstViewWillAppear(_ animated: Bool) { }

    func reloadData() {
        
        isNeedReloadWhenAppear = false
    }
    
    
    // MARK: Validation
    
    private lazy var validationGroup: SMValidationGroup = SMValidationGroup()
    
    func setupValidation(validators: [SMValidator]) {
        
        validationGroup.add(validators: validators)
    }
    
    func addValidator(validator: SMValidator?) {
        
        if let validator: SMValidator = validator {
            
            validationGroup.add(validator: validator)
        }
    }

    func cleanValidators() {
        
        validationGroup.removeAllValidators()
    }

    func checkValide() -> Bool {
        
        vc.view.endEditing(true)
        
        var result: Bool = true
        
        if validationGroup.validate().count > 0 {
            
            vc.showAlertWith(validator: validationGroup.validate().first?.validator)
            validationGroup.applyShakeForWrongFieldsIfCan()
            
            result = false
        }
        validationGroup.refreshStatesInFields()

        return result
    }
    
    
    // MARK: Request
    
    func apply(request aRequest: SMRequest, needActivity aNeedActivity: Bool = true, responseBlock aResponseBlock: @escaping SMRequestResponseBlock = { _ in}) {
        
        if aNeedActivity {
            
            vc.showActivity()
        }
        
        aRequest.startWithResponseBlockInMainQueue { [weak self] aResponse in // swiftlint:disable:this explicit_type_interface
            
            if aNeedActivity {
                
                self?.vc.hideActivity()
            }
            
            aResponseBlock(aResponse)
            if !aResponse.isSuccess {
                
                self?.vc.showAlertWith(response: aResponse)
            }
        }
    }
    
    @objc private func didRecieveReloadNotification() {
        
        switch updateBehavior() {
        case .reload:
            reloadData()
        case .non: break
        }
    }
    
    func updateBehavior() -> SMUpdateBehavior {
        
        return .non
    }
}
