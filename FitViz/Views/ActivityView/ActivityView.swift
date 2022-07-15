//
//  ActivityView.swift
//  FitViz
//
//  Created by Mike Griffin on 7/14/22.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel: ViewModel
    var body: some View {
        Text(viewModel.activity.type)
    }
}

//struct ActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView()
//    }
//}
