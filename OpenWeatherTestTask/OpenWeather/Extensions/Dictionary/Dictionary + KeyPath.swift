//
//  Dictionary + KeyPath.swift
//  OpenWeather
//
//  Created by Pavel Reva on 3/29/19.
//  Copyright © 2019 Pavel Reva. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    func value(forKeyPath keyPath: String, separator: String = ".") -> Any? {
        
        var result: Any?
        
        if !keyPath.contains(Character(separator)) {
            
            result = self[keyPath]
        } else {
            
            var nodes: [String.SubSequence] = keyPath.split(separator: Character(separator))
            
            if nodes.isEmpty {
                
                result = self[keyPath]
            } else {
                
                if let rootObject: Any = self[String(nodes[0])] {
                    
                    if nodes.count == 1 {
                        
                        result = rootObject
                    } else {
                        
                        if let dictionary: [String: Any] = rootObject as? [String: Any] {
                            
                            nodes = Array(nodes[1..<nodes.count])
                            
                            var newKeyPath: String = String()
                            
                            nodes.forEach { node in
                                
                                newKeyPath.append(contentsOf: String(node))
                                
                                if node != nodes.last {
                                    
                                    newKeyPath.append(contentsOf: separator)
                                }
                            }
                            
                            result = dictionary.value(forKeyPath: newKeyPath)
                            
                        } else {
                            
                            result = rootObject
                        }
                    }
                    
                } else {
                    
                    result = nil
                }
            }
        }
        
        return result
    }
}
