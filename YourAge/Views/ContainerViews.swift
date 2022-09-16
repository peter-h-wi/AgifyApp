//
//  InputContainerView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

struct ContainerView: View {
    let height: Double
    let width: Double

    let rectangleRadius = 18.0
    let circleRatio = 0.23
    
    let shadowRadius = 3.0
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(CC(.white))
                .cornerRadius(rectangleRadius)
                .shadow(radius: shadowRadius, x: shadowRadius, y: shadowRadius)
            ZStack {
                Circle()
                    .foregroundColor(CC(.white))
                    .frame(width: width * circleRatio)
                    .shadow(radius: shadowRadius, x:shadowRadius, y:shadowRadius)
                Rectangle()
                    .frame(width: width * circleRatio * 2, height: width * circleRatio)
                    .offset(y:-width * circleRatio * 0.5)
                    .foregroundColor(CC(.white))
            }
            .offset(y: height*0.5)
        }
    }
}

struct InputContainerView: View {
    let height: Double
    let width: Double
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        ZStack {
            ContainerView(height: height, width: width)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        vm.showHistory.toggle()
                        vm.retrieveHistory()
                    }) {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(CC(.yellow))
                            .font(.largeTitle)
                    }
                }
                .padding()
                Spacer()
            }
            .frame(width: width, height: height)
            
            TextField("Type a name", text: $vm.myName)
                .autocorrectionDisabled(true)
                .foregroundColor(CC(.fontGrey))
                .padding(13)
                .overlay(RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(CC(.lineGrey))
                )
                .padding(.horizontal)
            NextButton(containerWidth: width)
                .offset(y: height*0.5)
                .environmentObject(vm)
        }
        .frame(width: width, height: height*1.5)
    }
}

struct OutputContainerView: View {
    let height: Double
    let width: Double
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        ZStack {
            ContainerView(height: height, width: width)
            if vm.isValidData {
                Text("\(vm.myAge)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(CC(.fontGrey))
            } else {
                Text("Unknown 🧐")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(CC(.fontGrey))
            }
            
            OKButton(containerWidth: width)
                .offset(y: height*0.5)
                .environmentObject(vm)
        }
        .frame(width: width, height: height*1.5)
        
    }
}

struct HistoryContainerView: View {
    let height: Double
    let width: Double
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        ZStack {
            ContainerView(height: height, width: width)
            if (vm.dataHistory.isEmpty) {
                Text("There is no history")
                    .font(.title)
                    .foregroundColor(CC(.fontGrey))
            } else {
                List {
                    ForEach(vm.dataHistory) {
                        CardView(result: $0)
                            .padding()
                    }
                    .onDelete { offset in
                        vm.deleteItemFromHistory(at: offset)
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: height * 0.9)
            }
            OKButton2(containerWidth: width)
                .offset(y: height*0.5)
                .environmentObject(vm)
        }
    }
}
