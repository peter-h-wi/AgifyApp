//
//  MainModel.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import Foundation
import CoreData

struct MainModel: Codable {
    let name: String
    let age: Int
    let count: Int
}

struct MainModelLocal: Codable {
    let name: String
    let age: Int
    let count: Int
    let country_id: String
}

struct ResultModel: Identifiable {
    let modelData : ModelData
    
    var id: NSManagedObjectID {
        return modelData.objectID
    }
    
    var name: String {
        return modelData.name ?? ""
    }
    
    var age: Int {
        return Int(modelData.age)
    }
    
    var country: String {
        return modelData.country ?? "US"
    }
}
