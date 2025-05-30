//
//  CalorieData.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import Foundation
import CloudKit
import Combine

class CalorieData: ObservableObject {
    @Published var dailyGoal: Int = 3000
    @Published var totalConsumed: Int = 0

    private var container = CKContainer.default()
    private var recordID = CKRecord.ID(recordName: "CalorieData")

    init() {
        fetchData()
    }

    func fetchData() {
        let privateDB = container.privateCloudDatabase
        privateDB.fetch(withRecordID: recordID) { record, error in
            DispatchQueue.main.async {
                if let record = record {
                    self.dailyGoal = record["dailyGoal"] as? Int ?? 3000
                    self.totalConsumed = record["totalConsumed"] as? Int ?? 0
                }
            }
        }
    }

    func saveData() {
        let privateDB = container.privateCloudDatabase
        let record = CKRecord(recordType: "CalorieData", recordID: recordID)
        record["dailyGoal"] = dailyGoal as CKRecordValue
        record["totalConsumed"] = totalConsumed as CKRecordValue

        privateDB.save(record) { _, error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }
}
