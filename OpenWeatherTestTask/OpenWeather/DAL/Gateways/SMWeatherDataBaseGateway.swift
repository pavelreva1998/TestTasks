//
//  SMWeatherDataBaseGateway.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import FirebaseDatabase

class SMWeatherDataBaseGateway {
    
    static let shared: SMWeatherDataBaseGateway = SMWeatherDataBaseGateway()
    
    func getWeatherForUserID(userID: String, completion: @escaping (Any) -> Void) {
        
        let firebaseDBRequest: SMFirebaseDBRequest = SMFirebaseDBRequest(ref: Database.database().reference().child("users/\(userID)"))
        
        firebaseDBRequest.readData { value in
            
            completion(value)
        }
    }
    
    func setWeatherData(_ data: Any, for userID: String) {
        
        let firebaseDBRequest: SMFirebaseDBRequest = SMFirebaseDBRequest(ref: Database.database().reference().child("users/\(userID)"))
        firebaseDBRequest.writeData(data: data)
    }
}
