//
//  ButtonsView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

struct HalfCircleFrameView: View {
    let containerWidth: Double
    let innerRatio = 0.18
    var body: some View {
        ZStack() {
            Circle()
                .fill(buttonGradientColor)
                .frame(width: containerWidth * innerRatio)
        }
    }
}

struct NextButton: View {
    let containerWidth: Double
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        Button {
            vm.showResult.toggle()
        } label: {
            ZStack() {
                HalfCircleFrameView(containerWidth: containerWidth)
                Image(systemName: "arrow.right")
                    .font(.largeTitle)
                    .foregroundColor(CC(.white))
            }
        }
    }
}

struct OKButton: View {
    let containerWidth: Double
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        Button {
            vm.showResult.toggle()
        } label: {
            ZStack() {
                HalfCircleFrameView(containerWidth: containerWidth)
                Text("OK")
                    .font(.title)
                    .foregroundColor(CC(.white))
            }
        }
    }
}

struct OKButton2: View {
    let containerWidth: Double
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        Button {
            vm.showHistory.toggle()
        } label: {
            ZStack() {
                HalfCircleFrameView(containerWidth: containerWidth)
                Text("OK")
                    .font(.title)
                    .foregroundColor(CC(.white))
            }
        }
    }
}
