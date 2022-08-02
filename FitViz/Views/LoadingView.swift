//
//  LoadingView.swift
//  FitViz
//
//  Created by Mike Griffin on 8/1/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(2)
                .offset(y: -40)
        }
        }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
