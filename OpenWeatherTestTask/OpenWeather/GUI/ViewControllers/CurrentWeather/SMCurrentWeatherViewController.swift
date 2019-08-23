//
//  SMCurrentWeatherViewController.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.


import VRGSoftSwiftIOSKit

final class SMCurrentWeatherViewController: SMBaseViewController {
    
    @IBOutlet weak var ivWeather: UIImageView!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbOverView: UILabel!
    @IBOutlet weak var ivHumidity: UIImageView!
    @IBOutlet weak var ivPressure: UIImageView!
    @IBOutlet weak var lbHumidity: UILabel!
    @IBOutlet weak var lbPressure: UILabel!
    @IBOutlet weak var ivWind: UIImageView!
    @IBOutlet weak var lbWind: UILabel!
    @IBOutlet weak var btShare: UIButton!
    
    var weather: SMWeather?
    
    override func createPresenter() -> SMBasePresenter {
        
        let result: SMCurrentWeatherPresenter = SMCurrentWeatherPresenter(vc: self)
        
        return result
    }
    
    var custPresenter: SMCurrentWeatherPresenter? {
        
        return presenter as? SMCurrentWeatherPresenter
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureUI()
        prepareLocalization()
    }
    
    
    // MARK: Logic
    
    private func configureUI() {
        
        view.isHidden = true
        
        ivWind.setTintedImage(withName: "ic_wind")
        ivHumidity.setTintedImage(withName: "ic_humidity")
        ivPressure.setTintedImage(withName: "ic_pressure")
    }
    
    
    // MARK: Actions
    
    @IBAction func didBtShareClicked(_ sender: Any) {
        
        if let sharedText: String = weather?.description {
            
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [sharedText], applicationActivities: nil)
            
            if SMHelper.isIPad {
                
                activityViewController.popoverPresentationController?.sourceView = view
                
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.width/2, y: view.height, width: 0, height: 0)
            }
            
            present(activityViewController, animated: true)
        }
    }
    
    
    // MARK: Localization
    
    override func prepareLocalization() {
        
        title = "Today".localize()
        btShare.setTitle("Share".localize(), for: .normal)
    }
}


// MARK: SMCurrentWeatherPresenterProtocol

extension SMCurrentWeatherViewController: SMCurrentWeatherPresenterProtocol {
    
    func showErrorAlert() {
        
        if weather == nil {
            
            view.isHidden = true
        }
        
        showAlertWith(title: "", message: "error_text".localize())
    }
    
    func updateWithWeather(_ weather: SMWeather) {
        
        self.weather = weather
        
        ivWeather.setTintedImage(withName: weather.rawIcon ?? "")
        lbLocation.text = weather.formattedLocation
        lbOverView.text = "\(weather.formattedTemperature) | \(weather.skyState ?? "")"
        lbHumidity.text = weather.formattedHumidity
        lbPressure.text = weather.formattedPressure
        lbWind.text = weather.formattedWindSpeed
        
        view.isHidden = false
    }
}
