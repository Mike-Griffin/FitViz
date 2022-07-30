//
//  AlertItem.swift
//  FitViz
//
//  Created by Mike Griffin on 7/30/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let noUserRecord = AlertItem(title: Text("No User Found"),
                                            message: Text("You must log into iCloud on your phone in order to track FitViz activities. Please log in on your phone's setting screen."),
                                            dismissButton: .default(Text("Ok")))
}
