//
//  AuthService.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import FirebaseAuth

class AuthService {
    
    static let shared: AuthService = AuthService()

    var isLogined: Bool {
        
        return Auth.auth().currentUser != nil
    }
    
    var userID: String? {
        
        return Auth.auth().currentUser?.uid
    }
    
    func checkAuthStatus(compltion: @escaping (Bool) -> Void) {
        
        if isLogined {
            
            compltion(true)
        } else {
            
            login(compltion: compltion)
        }
    }
    
    func login(compltion: @escaping (Bool) -> Void) {
        
        Auth.auth().signInAnonymously { [weak self] authResult, error in // swiftlint:disable:this explicit_type_interface
            compltion(self?.isLogined == true)
        }
    }
    
    func logout() {
        
        try? Auth.auth().signOut()
    }
}
