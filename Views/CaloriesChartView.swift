//
//  CaloriesChartView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 30.05.2025.
//

import SwiftUI
import Foundation
import CloudKit
import Charts


struct CaloriesChartView: View {
    var data: [DailyCalories]

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Weekly Calories")
                .font(.headline)
                .foregroundColor(.orange)
                .padding(.leading)

            Chart(data, id: \.id) { entry in
                BarMark(
                    x: .value("Zi", dateFormatter.string(from: entry.date)),
                    y: .value("Calories", entry.calories)
                )
                .foregroundStyle(entry.calories > 2200 ? .red : (entry.calories > 1800 ? .orange : .green))
            }
            .frame(height: 180)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}
