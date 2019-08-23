//
//  SMFirebaseDBRequest.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/12/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//


import FirebaseDatabase

class SMFirebaseDBRequest {
    
    let ref: DatabaseReference
    
    init(ref: DatabaseReference) {
        
        self.ref = ref
    }
    
    func readData(completion: @escaping ([String: Any]) -> Void) {
        
        ref.observeSingleEvent(of: .value) { snapshot in
            
            completion(snapshot.value as? [String: Any] ?? [:])
        }
    }
    
    func writeData(data: Any) {
        
        ref.setValue(data)
    }
}
