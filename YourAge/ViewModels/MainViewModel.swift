//
//  MainViewModel.swift
//  YourAge
//
//  Created by peter wi on 9/13/22.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var myName: String
    @Published var myAge: Int
    @Published var showResult: Bool
    @Published var isValidData: Bool
    @Published var countryCode: String
    @Published var isLocalized: Bool
    @Published var showHistory: Bool
    @Published var dataHistory: [ResultModel] = []
    
    init() {
        myName = ""
        myAge = 20
        showResult = false
        isValidData = false
        isLocalized = false
        showHistory = false
        countryCode = Locale.current.language.region?.identifier ?? "US"
    }
    
    func getData() {
        let temp: String
        if isLocalized {
            temp = "https://api.agify.io/?name=\(myName)&country_id=\(countryCode)"
        } else {
            temp = "https://api.agify.io/?name=\(myName)"
        }
        guard let url = URL(string: temp) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async{ [self] in
                if isLocalized {
                    if let decodedResponse = try? JSONDecoder().decode(MainModelLocal.self, from: data!) {
                        self.myName = decodedResponse.name
                        self.myAge = decodedResponse.age
                        self.countryCode = decodedResponse.country_id
                        self.isValidData = true
                        addItemToHistory()
                    } else {
                        self.isValidData = false
                    }
                } else {
                    if let decodedResponse = try? JSONDecoder().decode(MainModel.self, from: data!) {
                        self.myName = decodedResponse.name
                        self.myAge = decodedResponse.age
                        self.isValidData = true
                        self.countryCode = "World"
                        addItemToHistory()
                        // reset the code to current location
                        self.countryCode = Locale.current.language.region?.identifier ?? "US"
                    } else {
                        self.isValidData = false
                    }
                }
            }
        }
        .resume()
    }
    
    func retrieveHistory() {
        dataHistory = CoreDataManager.shared.getAllItems().map(ResultModel.init)
        dataHistory.reverse()
    }
    
    func addItemToHistory() {
        let hasOne = dataHistory.contains { model in
            return model.name == myName && model.age == myAge && model.country == countryCode
        }
        if hasOne {
            print("already have the same one")
            return
        }
        let item = ModelData(context: CoreDataManager.shared.viewContext)
        item.country = countryCode
        item.name = myName
        item.age = Int16(myAge)
        CoreDataManager.shared.save()
        retrieveHistory()
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
