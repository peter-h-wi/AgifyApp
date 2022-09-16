//
//  HistoryView.swift
//  YourAge
//
//  Created by peter wi on 9/16/22.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundGradientColor
                VStack {
                    IntroMessageView(introMain1: "Check out", introMain2: "history,", introSub: "Were the predictions accurate?", height: 0)
                        .padding()
                        .padding(.top)
                    Spacer()
                }
                HistoryContainerView(height: geo.size.height*0.7, width: geo.size.width*0.9)
            }
        }
        .ignoresSafeArea()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView().environmentObject(MainViewModel())
    }
}
