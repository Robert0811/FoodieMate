//
//  DailyCalories.swift
//  FoodieMate
//
//  Created by Robert Trifan on 30.05.2025.
//

import Foundation
import CloudKit

class DailyCalories: NSObject, Identifiable {
    var id: UUID
    var recordID: CKRecord.ID?
    var date: Date
    var calories: Int
    
    // MARK: - Initializers
    
    init(id: UUID = UUID(), recordID: CKRecord.ID? = nil, date: Date, calories: Int) {
        self.id = id
        self.recordID = recordID
        self.date = date
        self.calories = calories
    }
    
    convenience init?(record: CKRecord) {
        guard let date = record["date"] as? Date,
              let calories = record["calories"] as? Int else {
            return nil
        }
        
        self.init(
            id: UUID(), // Poți folosi și UUID(uuidString: record.recordID.recordName) dacă vrei să păstrezi legătura.
            recordID: record.recordID,
            date: date,
            calories: calories
        )
    }
    
    // MARK: - Convert to CKRecord
    
    func toCKRecord() -> CKRecord {
        let record: CKRecord
        if let recordID = recordID {
            record = CKRecord(recordType: "DailyCalories", recordID: recordID)
        } else {
            record = CKRecord(recordType: "DailyCalories")
            self.recordID = record.recordID
        }
        
        record["date"] = date as CKRecordValue
        record["calories"] = calories as CKRecordValue
        
        return record
    }
}
