//
//  CloudKitManager.swift
//  FitViz
//
//  Created by Mike Griffin on 5/2/22.
//

import Foundation
import CloudKit

struct CloudKitManager {
    let container = CKContainer(identifier: "iCloud.com.comedichoney.FitnessVisualizer")
    
    // MARK: Activities
    func loadActivities() async throws -> [FVActivity] {
        print("activities are being loaded")
        let query = CKQuery(recordType: RecordType.activity, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: FVActivity.kTimestamp, ascending: false)]
        
        let (matchResults, _) = try await container.privateCloudDatabase.records(matching: query)
        let records = matchResults.compactMap { _, result in try? result.get() }
        return records.map(FVActivity.init)
    }
    
    func fetchSameDistanceActivities(activity: FVActivity) async throws -> [FVActivity] {
        let lowerboundDistance = activity.distanceRange.lowerBound
        let upperboundDistance = activity.distanceRange.upperBound
        let predicate = NSPredicate(format: "distance >= %d && distance < %d && type == %@", lowerboundDistance, upperboundDistance, activity.type)
        let query = CKQuery(recordType: RecordType.activity, predicate: predicate)
        let (matchResults, _) = try await container.privateCloudDatabase.records(matching: query)
        let records = matchResults.compactMap { _, result in try? result.get() }
        return records.map(FVActivity.init)
    }
    
    func deleteAllActivities() async throws {
        let query = CKQuery(recordType: RecordType.activity, predicate: NSPredicate(value: true))
        
        let (matchResults, _) = try await container.privateCloudDatabase.records(matching: query)
        let records = matchResults.compactMap { _, result in try? result.get() }
        
        for record in records {
            // TODO return something for the success case?
            let _ = try await container.privateCloudDatabase.modifyRecords(saving: [], deleting: [record.recordID])
        }
    }
    
    // MARK: Source
    func getSourceInformation(source: Source) async throws -> FVSourceInformation? {
        let predicate = NSPredicate(format: "source == %@", source.rawValue)
        let query = CKQuery(recordType: RecordType.sourceInformation, predicate: predicate)
        let (matchRecords, _) = try await container.privateCloudDatabase.records(matching: query)
        let records = matchRecords.compactMap { _, result in try? result.get() }
        guard let relevantRecord = records.first else {
            return nil
        }
        return FVSourceInformation(record: relevantRecord)
    }
    
    func getSourceInformationRecord(source: Source) async throws -> CKRecord? {
        let predicate = NSPredicate(format: "source == %@", source.rawValue)
        let query = CKQuery(recordType: RecordType.sourceInformation, predicate: predicate)
        let (matchRecords, _) = try await container.privateCloudDatabase.records(matching: query)
        let records = matchRecords.compactMap { _, result in try? result.get() }
        return records.first
    }
    
    func deleteSourceInformationRecord(source: Source) async throws {
        do {
            if let record = try await getSourceInformationRecord(source: source) {
                let _ = try await container.privateCloudDatabase.deleteRecord(withID: record.recordID)
            }
        }
    }
    
    // MARK: Generic records
    func batchSave(records: [CKRecord]) async throws -> [CKRecord] {
        let (savedResults, _) = try await container.privateCloudDatabase.modifyRecords(saving: records, deleting: [])
        return savedResults.compactMap { _, result in try? result.get() }
    }
    
    func save(record: CKRecord) async throws -> CKRecord {
        return try await container.privateCloudDatabase.save(record)
    }
    
    func fetchRecord(with id: CKRecord.ID) async throws -> CKRecord {
        return try await container.privateCloudDatabase.record(for: id)
    }
}
