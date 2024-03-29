//
//  JSONSerializable.swift
//  FoodNutritionApp
//
//  Created by Aine Barry on 06/03/2017.
//  Copyright © 2017 Aine Barry. All rights reserved.
//

import Foundation


protocol JSONSerializable: JSONRepresentable {
    
}

extension JSONSerializable {
    var JSONRepresentation: Any {
        var representation = [String: Any]()
        
        for case let(label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as Dictionary<String, Any>:
                representation[label] = value as AnyObject
                
                
            case let value as Array<Any>:
                if let val = value as? [JSONSerializable] {
                    representation[label] = val.map({ $0.JSONRepresentation as AnyObject}) as AnyObject
                } else {
                    representation[label] = value as AnyObject
                }
                
            case let value:
                representation[label] = value as AnyObject
            
            default:
                // Ignore things that cannot be serialized
            break
            }
        }
        
        return representation as Any
    }
}

extension JSONSerializable {
    func toJSON() -> String? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            print("Invalid JSON Representation")
            return nil
        }
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject:representation, options: [])
            
            return String(data:data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
