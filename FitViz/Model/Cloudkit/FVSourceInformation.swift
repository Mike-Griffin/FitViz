//
//  FVSourceInformation.swift
//  FitViz
//
//  Created by Mike Griffin on 6/21/22.
//

import Foundation
import CloudKit

struct FVSourceInformation: Identifiable {
    static let kSource           = "source"
    static let kLastFetched      = "lastFetched"
    
    let id: CKRecord.ID
    let source: String
    let lastFetched: Int
    
    init(record: CKRecord) {
        id = record.recordID
        source = record[FVSourceInformation.kSource] as? String ?? "N/A"
        lastFetched = record[FVSourceInformation.kLastFetched] as? Int ?? 0
    }
}
