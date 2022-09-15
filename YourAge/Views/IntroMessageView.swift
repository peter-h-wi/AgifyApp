//
//  IntroMessageView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

// Used for top message on background
struct IntroMessageView: View {
    let introMain1: String
    let introMain2: String
    let introSub: String
    let height: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("ageIcons2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .opacity(0.5)
            }
            .padding(.trailing)
            VStack(alignment: .leading) {
                HStack {
                    Text(introMain1)
                        .fontWeight(.light)
                    Text(introMain2)
                        .fontWeight(.medium)
                }
                .font(.largeTitle)
                .foregroundColor(CC(.yellow))
                Text(introSub)
                    .fontWeight(.light)
                    .foregroundColor(CC(.white))
            }
        }
    }
}
