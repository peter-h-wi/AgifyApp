//
//  ResultModel.swift
//  YourAge
//
//  Created by peter wi on 9/15/22.
//

import Foundation
import CoreData

struct ResultModel {
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
    
    var count: Int {
        return Int(modelData.count)
    }
}
