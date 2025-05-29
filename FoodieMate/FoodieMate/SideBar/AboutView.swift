//
//  AboutView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("About FoodieMate")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.orange)
                .padding(.top, 50)

            Text("FoodieMate is your personal assistant for a healthy lifestyle. It helps you track your meals, calculate your BMI, and maintain a balanced diet.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("Version 1.0.0")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .background(Color(red: 1.0, green: 0.98, blue: 0.95).ignoresSafeArea())
    }
}

#Preview {
    AboutView()
}
