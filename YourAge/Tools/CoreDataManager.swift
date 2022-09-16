//
//  CoreDataManager.swift
//  YourAge
//
//  Created by peter wi on 9/16/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
            
        }
    }
    
    func getAllItems() -> [ModelData] {
        let request: NSFetchRequest<ModelData> = ModelData.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getDataBy(id: NSManagedObjectID) -> ModelData? {
        do {
            return try viewContext.existingObject(with: id) as? ModelData
        } catch {
            return nil
        }
    }
    
    func delete(entry: ModelData) {
        viewContext.delete(entry)
        save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    
}
