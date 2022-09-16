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
    
    init() {
        myName = ""
        myAge = 20
        showResult = false
        isValidData = false
        isLocalized = false
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
                    } else {
                        self.isValidData = false
                    }
                } else {
                    if let decodedResponse = try? JSONDecoder().decode(MainModel.self, from: data!) {
                        self.myName = decodedResponse.name
                        self.myAge = decodedResponse.age
                        self.isValidData = true
                        self.countryCode = Locale.current.language.region?.identifier ?? "US"
                    } else {
                        self.isValidData = false
                    }
                }
            }
        }
        .resume()
    }
}
