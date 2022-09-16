//
//  HomeView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

let buttonGradientColor = LinearGradient(gradient: buttonGradient, startPoint: .topLeading, endPoint: .bottomTrailing)

struct HomeView: View {
    @StateObject private var vm = MainViewModel()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundGradientColor
                
                VStack(alignment: .leading) {
                    IntroMessageView(introMain1: "Welcome to", introMain2: "Agify,", introSub: "Predict the age of a name", height: geo.size.height*0.4*0.4)
                        .padding(.leading)
                        .frame(height: geo.size.height*0.4)
                    CC(.backgroundGrey)
                }
                InputContainerView(height: geo.size.height*0.4, width: geo.size.width*0.9)
                    .environmentObject(vm)
            }
        }
        .ignoresSafeArea()
        .popover(isPresented: $vm.showResult) {
            PopOverView().environmentObject(vm)
        }
        .popover(isPresented: $vm.showHistory) {
            HistoryView().environmentObject(vm)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
