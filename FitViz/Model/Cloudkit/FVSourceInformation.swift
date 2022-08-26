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
    static let kFirstFetched     = "firstFetched"
    
    let id: CKRecord.ID
    let source: String
    let lastFetched: Int
    let firstFetched: Int
    
    init(record: CKRecord) {
        id = record.recordID
        source = record[FVSourceInformation.kSource] as? String ?? "N/A"
        lastFetched = record[FVSourceInformation.kLastFetched] as? Int ?? 0
        firstFetched = record[FVSourceInformation.kFirstFetched] as? Int ?? 0
    }
}
