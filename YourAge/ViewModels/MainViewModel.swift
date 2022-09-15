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
    
    init() {
        myName = ""
        myAge = 20
        showResult = false
        isValidData = false
    }
    
    func getData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(myName)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async{ [self] in
                if let decodedResponse = try? JSONDecoder().decode(MainModel.self, from: data!) {
                    self.myName = decodedResponse.name
                    self.myAge = decodedResponse.age
                    self.isValidData = true
                } else {
                    self.isValidData = false
                }
            }
        }
        .resume()
    }
}
