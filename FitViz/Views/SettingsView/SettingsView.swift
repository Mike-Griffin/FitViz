//
//  SettingsView.swift
//  FitViz
//
//  Created by Mike Griffin on 6/4/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("distanceUnit") private var distanceUnit = DistanceUnit.miles
    var body: some View {
        Form {
            Picker("Distance Unit", selection: $distanceUnit) {
                ForEach(DistanceUnit.allCases) { unit in
                    Text(unit.rawValue.capitalized)
                    
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
