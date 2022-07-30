//
//  MapSheetView.swift
//  FitViz
//
//  Created by Mike Griffin on 7/27/22.
//

import SwiftUI
import MapKit

struct MapSheetView: View {
    var region: MKCoordinateRegion
    @Binding var presented: Bool
    var body: some View {
        VStack {
            Button {
                presented = false
            } label: {
                Text("Dismiss")
            }
            MapView(region: region, lineCoordinates: [])

        }
    }
}
