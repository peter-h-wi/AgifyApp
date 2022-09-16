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
                    Text("United Kingdom")
                    Image(systemName: "globe")
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
        return result.age < 40 ? CC(.yellow) : result.age < 70 ? CC(.pink) : CC(.green)
    }
}
