//
//  Binding+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 8/6/22.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping(Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue},
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
