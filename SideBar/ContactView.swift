//
//  ContactView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("ContactStart"), Color("ContactEnd")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Contact Us")
                    .font(.largeTitle.bold())
                    .foregroundColor(.orange)
                    .padding(.top, 50)

                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("trifanrobert55@yahoo.com")
                            .font(.headline)
                    }

                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)
                        Text("+40 786 578 956")
                            .font(.headline)
                    }

                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.red)
                        Text("Brașov, România")
                            .font(.headline)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContactView()
}
