//
//  CustomColor.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import Foundation
import SwiftUI


let buttonGradient = Gradient(colors: [CC(.yellow), CC(.pink)])
let backgroundGradient = Gradient(colors: [CC(.green), CC(.blue)])

enum CustomColor {
    case backgroundGrey, fontGrey, lineGrey, yellow, white, pink, green, blue
}

func CC(_ color: CustomColor) -> Color {
    switch color {
    case .backgroundGrey:
        return Color(red: 240/255, green: 240/255, blue: 240/255)
    case .fontGrey:
        return Color(red: 122/255, green: 122/255, blue: 122/255)
    case .lineGrey:
        return Color(red: 206/255, green: 206/255, blue: 206/255)
    case .yellow:
        return Color(red: 255/255, green: 179/255, blue: 13/255)
    case .white:
        return Color(red: 255/255, green: 255/255, blue: 255/255)
    case .pink:
        return Color(red: 255/255, green: 0/255, blue: 153/255, opacity: 0.44)
    case .green:
        return Color(red: 8/255, green: 84/255, blue: 84/255)
    case .blue:
        return Color(red: 0/255, green: 21/255, blue: 66/255)
    }
}

