//
//  InputContainerView.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import SwiftUI

struct InputContainerView: View {
    let height: Double
    let width: Double
    @EnvironmentObject private var vm: MainViewModel
    
    var body: some View {
        ZStack {
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
                TextField("Type a name", text: $vm.myName)
                    .autocorrectionDisabled(true)
                    .foregroundColor(CC(.fontGrey))
                    .padding(13)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(CC(.lineGrey)))
                    .padding()
                
                Toggle("Improve accuracy with localization", isOn: $vm.isLocalized.animation())
                    .fontWeight(.light)
                    .foregroundColor(CC(.fontGrey))
                    .padding()
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
                Spacer()
            }
            .frame(width: width, height: height)
            .background(CC(.white))
            .cornerRadius(18)
            .shadow(radius: 3, x: 3, y: 3)
            
            NextButton(containerWidth: width)
                .background(Rectangle().size(width: width*0.18+30, height:width*0.09+13).fill(CC(.white)).offset(x:-11, y: -13))
                .padding(10)
                .background(Circle().fill(CC(.white)).shadow(radius: 3, x: 3, y: 3))
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
            VStack {
                Spacer()
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
                Spacer()
            }
            .frame(width: width, height: height)
            .background(CC(.white))
            .cornerRadius(18)
            .shadow(radius: 3, x: 3, y: 3)
            
            
            OKButton(containerWidth: width)
                .background(Rectangle().size(width: width*0.18+30, height:width*0.09+13).fill(CC(.white)).offset(x:-11, y: -13))
                .padding(10)
                .background(Circle().fill(CC(.white)).shadow(radius: 3, x: 3, y: 3))
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
            VStack {
                if (vm.dataHistory.isEmpty) {
                    Spacer()
                    Text("There is no history")
                        .font(.title)
                        .foregroundColor(CC(.fontGrey))
                    Spacer()
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
            }
            .frame(width: width, height: height)
            .background(CC(.white))
            .cornerRadius(18)
            .shadow(radius: 3, x: 3, y: 3)
            
            OKButton2(containerWidth: width)
                .background(Rectangle().size(width: width*0.18+30, height:width*0.09+13).fill(CC(.white)).offset(x:-11, y: -13))
                .padding(10)
                .background(Circle().fill(CC(.white)).shadow(radius: 3, x: 3, y: 3))
                .offset(y: height*0.5)
                .environmentObject(vm)
        }
    }
}
