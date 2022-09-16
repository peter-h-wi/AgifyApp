//
//  PopOverView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

let backgroundGradientColor = LinearGradient(gradient: backgroundGradient, startPoint: .topLeading, endPoint: .bottomTrailing)

struct PopOverView: View {
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundGradientColor
                VStack(alignment: .leading) {
                    IntroMessageView(introMain1: "The age of", introMain2: "\(vm.myName),", introSub: "Prediction may not be accurate", height: geo.size.height*0.4*0.4)
                        .padding(.leading)
                        .frame(height: geo.size.height*0.4)
                    Spacer()
                }
                
                OutputContainerView(height: geo.size.height*0.45, width: geo.size.width*0.9)
                    .environmentObject(vm)
            }
        }
        .ignoresSafeArea()
        .task {
            vm.getData()
        }
    }
}

struct PopOverView_Previews: PreviewProvider {
    static var previews: some View {
        PopOverView().environmentObject(MainViewModel())
    }
}
