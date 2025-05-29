//
//  MealPlanView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import SwiftUI

struct MealPlanView: View {
    var body: some View {
        VStack {
            Text("Meal Plan")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.orange)
            
            Spacer()
        }
        .padding()
    }
}

struct MealPlanView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlanView()
    }
}

