//
//  SMBaseViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import UIKit
import VRGSoftSwiftIOSKit


public protocol SMBaseViewControllerMakerProtocol { }

extension SMBaseViewControllerMakerProtocol where Self: SMBaseViewController {
    
    static func make(representObject aRepresentObject: Any?) -> Self {
        
        let vc: Self = self.init()
        
        vc.representObject = aRepresentObject
        
        return vc
    }
}

extension SMBaseViewController: SMBaseViewControllerMakerProtocol { }


class SMBaseViewController: SMViewController {
    
    deinit {
        print(#function + " - \(type(of: self))")
    }
    
    var presenter: SMBasePresenter?

    
    // MARK: Represent
    
    var representObject: Any?
    
    func updateRepresentation() {
        
        updateRepresentation(representObject: representObject)
    }
    
    func updateRepresentation(representObject aRepresentObject: Any?) {
        
        presenter?.representObject = aRepresentObject
    }
    

    // MARK: For override
    
    func createPresenter() -> SMBasePresenter? {
        
        return nil
    }
    
    func navBarColor() -> UIColor? {
        
        return .white
    }
    
    func navBarImage() -> UIImage? {
        
        return nil
    }
    
    override func createLeftNavButton() -> UIBarButtonItem? {
        
       return nil
    }
    
    override func createRightNavButton() -> UIBarButtonItem? {
        
        return nil
    }
    
   
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter = createPresenter()
        presenter?.representObject = representObject
        
        view.backgroundColor = .white
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if isFirstAppear {

            presenter?.firstViewWillAppear(animated)
        }
        
        presenter?.viewWillAppear(animated)

        if let navigationController: UINavigationController = self.navigationController {
            
            if let navImage: UIImage = navBarImage() {
                
                navigationController.navigationBar.setBackgroundImage(navImage, for: UIBarMetrics.default)
            } else if let navBarColor: UIColor = navBarColor() {
                
                let navBarBackground: UIImage? = UIImage.imageWith(color: navBarColor, size: CGSize(width: 1.0, height: 1.0))?.resizableImage(withCapInsets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
                navigationController.navigationBar.setBackgroundImage(navBarBackground, for: UIBarMetrics.default)
                navigationController.navigationBar.shadowImage = UIImage.imageWith(color: UIColorFromRGB(rgbValue: 0xefefef), size: CGSize(width: 1.0, height: 1.0))
                navigationController.navigationBar.isTranslucent = false
            } else {
                
                navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                navigationController.navigationBar.shadowImage = UIImage()
                navigationController.navigationBar.isTranslucent = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        presenter?.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear(animated)
    }
    
    override func close() {
        
        super.close()
        
        presenter?.close()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    

    // MARK: Alert
    
    func showAlertWith(error aError: Error?) {
        
        if let error: Error = aError {
            sm_showAlertController(title: "", message: error.localizedDescription, cancelButtonTitle: "ok".localize())
        }
    }

    func showAlertWith(response aResponse: SMResponse?) {
        
        let titleMessage: String = aResponse?.titleMessage ?? ""
        
        if let textMessage: String = aResponse?.textMessage {
            
            if !textMessage.isEmpty {
                
                sm_showAlertController(title: titleMessage, message: textMessage, cancelButtonTitle: "ok".localize())
            }
        }
    }
    
    func showAlertWith(validator aValidator: SMValidator?) {
        
        if let validator: SMValidator = aValidator {
            
            sm_showAlertController(title: validator.titleMessage, message: validator.errorMessage, cancelButtonTitle: "ok".localize())
        }
    }

    func showAlertWith(title aTitle: String?, message aMessage: String?) {
        
        if aTitle != nil || aMessage != nil {
            
            self.sm_showAlertController(title: aTitle, message: aMessage, cancelButtonTitle: "ok".localize())
        }
    }
    
    func showAlertWith(title aTitle: String?, message aMessage: String?, handler aHandler: ((SMAlertController, Int) -> Void)?) {
        
        if aTitle != nil || aMessage != nil {
            
            self.sm_showAlertController(title: aTitle, message: aMessage, cancelButtonTitle: "ok".localize(), otherButtonTitles: nil, handler: aHandler)
        }
    }
    
    
    // MARK: Navigation
    
    func pushViewController(_ viewController: SMBaseViewController) {
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentDefault(_ viewController: SMBaseViewController, withAnimation: Bool = true) {
        
        let nc: UINavigationController = UINavigationController(rootViewController: viewController)
        self.present(nc, animated: withAnimation, completion: nil)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    
    // MARK: Localiztion
    
    func prepareLocalization() {
        
    }
}
