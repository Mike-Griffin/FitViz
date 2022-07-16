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
    func loadActivities(completed: @escaping (Result<[FVActivity], Error>) -> ()) {
        print("activities are being loaded")
        let query = CKQuery(recordType: RecordType.activity, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: FVActivity.kTimestamp, ascending: false)]
        
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let records = records else { return }
            
            let activities = records.map { $0.mapToFVActivity() }
            completed(.success(activities))
        }
    }
    
    func fetchSameDistanceActivities(activity: FVActivity, completed: @escaping (Result<[FVActivity], Error>) -> ()) {
        let lowerboundDistance = activity.distanceRange.lowerBound
        var upperboundDistance = activity.distanceRange.upperBound
        let predicate = NSPredicate(format: "distance >= %d && distance < %d && type == %@", lowerboundDistance, upperboundDistance, activity.type)
        print(predicate)
        let query = CKQuery(recordType: RecordType.activity, predicate: predicate)
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let records = records else { return }
            let activities = records.map { $0.mapToFVActivity() }
            completed(.success(activities))
        }
    }
    
    func deleteAllActivities() {
        let query = CKQuery(recordType: RecordType.activity, predicate: NSPredicate(value: true))
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                
                for record in records! {
                    
                    container.privateCloudDatabase.delete(withRecordID: record.recordID, completionHandler: { (recordId, error) in
                        
                        if error == nil {
                            print("record deleted")
                            print(recordId)
                            //Record deleted
                            
                        }
                        
                    })
                    
                }
                
            }
        }
    }
    
    
    
    // MARK: Source
    func getSourceInformation(source: Source, completed: @escaping (Result<FVSourceInformation?, Error>) -> ()) {
        let predicate = NSPredicate(format: "source == %@", source.rawValue)
        let query = CKQuery(recordType: RecordType.sourceInformation, predicate: predicate)
        
        container.privateCloudDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let relevantRecord = records?.first else {
                completed(.success(nil))
                return
            }
            
            let source = relevantRecord.mapToFVSourceInformation()
            completed(.success(source))
        }
    }
    
    // MARK: Generic records
    func batchSave(records: [CKRecord], completed: @escaping (Result<[CKRecord], Error>) -> Void) {
        //        let container = CKContainer(identifier: "iCloud.com.comedichoney.FitnessVisualizer")
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil else {
                print(error!.localizedDescription)
                completed(.failure(error!))
                return
            }
            
            completed(.success(savedRecords))
        }
        
        container.privateCloudDatabase.add(operation)
    }
    
    
}
