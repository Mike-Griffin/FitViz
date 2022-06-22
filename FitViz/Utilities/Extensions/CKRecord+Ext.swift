//
//  CKRecord+Ext.swift
//  FitViz
//
//  Created by Mike Griffin on 5/21/22.
//

import Foundation
import CloudKit

extension CKRecord {
    func mapToFVActivity() -> FVActivity {
        print(self)
        print(self["distance"])
        return FVActivity(record: self)
        
    }
    
    func mapToFVSourceInformation() -> FVSourceInformation {
        return FVSourceInformation(record: self)
    }
}
