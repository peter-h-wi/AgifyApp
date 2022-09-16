//
//  CardView.swift
//  YourAge
//
//  Created by peter wi on 9/16/22.
//

import SwiftUI

struct CardView: View {
    let result: ResultModel
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(result.name)
                    .font(.headline)
                    .foregroundColor(CC(.yellow))
                HStack {
                    MainTool.getSafeImage(named: "\(result.country.lowercased()).png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 15)
                    Text(MainTool.countryName(countryCode: result.country) ?? "Unknown")
                }
                .font(.subheadline)
                .foregroundColor(CC(.fontGrey))
            }
            Spacer()
            Text("\(result.age)")
                .font(.title)
                .foregroundColor(myColor())
                .padding(5)
                .overlay(Circle().stroke().foregroundColor(myColor()))
        }
    }
    
    func myColor() -> Color {
        return result.age < 30 ? CC(.yellow) : result.age < 60 ? CC(.pink) : CC(.green)
    }
}
