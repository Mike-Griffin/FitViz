//
//  DeveloperView.swift
//  FitViz
//
//  Created by Mike Griffin on 6/12/22.
//

import SwiftUI

struct DeveloperView: View {
    @ObservedObject private var viewModel = ViewModel()
    var body: some View {
        Form {
            HStack {
                VStack(alignment: .leading) {
                    Text("Strava Access Code")
                        .font(.headline)
                TextField("Strava Access Code", text: $viewModel.stravaAccessCode)
                }
            Button {
                print("yeah we be setting the strava code \(viewModel.stravaAccessCode)")
                viewModel.setStravaAccessCodeToKeychain()
            } label: {
                Text("Set")
            }
            }

        }
    }
}

struct DeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperView()
    }
}
