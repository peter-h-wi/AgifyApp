//
//  ResultModel.swift
//  YourAge
//
//  Created by peter wi on 9/15/22.
//

import Foundation
import CoreData

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
    
    var count: Int {
        return Int(modelData.count)
    }
    
    var country: String {
        return modelData.country ?? "US"
    }
}
