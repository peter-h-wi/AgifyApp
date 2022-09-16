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
    @State var countryId: String = ""
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        ZStack {
            ContainerView(height: height, width: width)
            VStack {
                TextField("Type a name", text: $vm.myName)
                    .autocorrectionDisabled(true)
                    .foregroundColor(CC(.fontGrey))
                    .padding(13)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(CC(.lineGrey)))
                    .padding()
                
                HStack {
                    Toggle("Improve accuracy with localization", isOn: $vm.isLocalized.animation())
                        .fontWeight(.light)
                        .foregroundColor(CC(.fontGrey))
                }
                .padding(.top)
                .padding(.horizontal)
                
                if vm.isLocalized {
                    HStack {
                        MainTool.getSafeImage(named: "\(vm.countryCode.lowercased()).png")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Spacer()
                        CountryPicker().environmentObject(vm)
                            .foregroundColor(CC(.fontGrey))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 6)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(CC(.lineGrey)))
                    .padding(.horizontal)
                }
            }
            
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
    @Environment(\.locale) var locale

    var body: some View {
        ZStack {
            ContainerView(height: height, width: width)
            VStack {
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
                if vm.isLocalized {
                    HStack {
                        MainTool.getSafeImage(named: "\(vm.countryCode.lowercased()).png")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Spacer()
                        Text(MainTool.countryName(countryCode: vm.countryCode) ?? "Unknown")
                            .foregroundColor(CC(.fontGrey))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 6)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(CC(.lineGrey)))
                    .padding(.horizontal)
                }
            }
            
            
            OKButton(containerWidth: width)
                .offset(y: height*0.5)
                .environmentObject(vm)
        }
        .frame(width: width, height: height*1.5)
    }
}
