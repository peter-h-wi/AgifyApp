//
//  Pickers.swift
//  YourAge
//
//  Created by peter wi on 9/15/22.
//

import SwiftUI

let countries = Locale.Region.isoRegions.filter({$0.identifier.count==2})

struct CountryPicker: View {
    @Environment(\.locale) var locale
    @EnvironmentObject private var vm: MainViewModel
    @State var showText = false

    var body: some View {
        Picker("", selection: $vm.countryCode) {
            ForEach(countries.sorted(by: {locale.localizedString(forRegionCode: $0.identifier)! < locale.localizedString(forRegionCode: $1.identifier)!}), id: \.self) { iso in
                Text(locale.localizedString(forRegionCode: iso.identifier)!)
                    .tag(iso.identifier)
            }
        }
    }
}
