//
//  MainTool.swift
//  YourAge
//
//  Created by peter wi on 9/15/22.
//

import Foundation
import SwiftUI

class MainTool {
    static func getSafeImage(named: String) -> Image {
        
        guard let uiImage = UIImage(named: named) else {
            return Image(systemName: "globe")
        }
    
        return Image(uiImage: uiImage)
    }
    
    static func countryName(countryCode: String) -> String? {
        if countryCode == "World" {
            return countryCode
        }
        print(countryCode)
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }
}
