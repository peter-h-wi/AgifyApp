//
//  MainViewModel2.swift
//  YourAge
//
//  Created by peter wi on 9/15/22.
//

import Foundation

class MainViewModel2: ObservableObject {
    @Published var myName: String
    @Published var myAge: Int
    @Published var myCountryID: String
    @Published var myCount: Int
    @Published var showResult: Bool
    @Published var isValidData: Bool
    @Published var showHistory: Bool
    var dataHistory: [ResultModel] = []
    
    init() {
        myName = ""
        myAge = 20
        myCountryID = "US"
        myCount = 0
        showResult = false
        showHistory = false
        isValidData = false
    }
    
    func getData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(myName)&country_id=US") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async{ [self] in
                if let decodedResponse = try? JSONDecoder().decode(MainModel.self, from: data!) {
                    self.myName = decodedResponse.name
                    self.myAge = decodedResponse.age
                    self.isValidData = true
                    addItemToHistory()
                } else {
                    self.isValidData = false
                    print("Why")
                }
            }
        }
        .resume()
    }
    
    func retrieveHistory() {
        dataHistory = CoreDataManager.shared.getAllItems().map(ResultModel.init)
    }
    
    func addItemToHistory() {
        let hasOne = dataHistory.contains { model in
            return model.name == myName && model.age == myAge && model.country == myCountryID
        }
        if hasOne {
            print("already have the same one")
            return
        }
        let item = ModelData(context: CoreDataManager.shared.viewContext)
        item.country = myCountryID
        item.count = Int64(myCount)
        item.name = myName
        item.age = Int64(myAge)
        CoreDataManager.shared.save()
        print("Add Done")
    }
    
    func deleteItemFromHistory(at offsets: IndexSet) {
        for index in offsets {
            let item = dataHistory[index]
            CoreDataManager.shared.delete(entry: item.modelData)
        }
        retrieveHistory()
        print("Delete Done")
    }
}
