//
//  RecipesView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        VStack {
            Text("Recipes")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.orange)
            
            Spacer()
        }
        .padding()
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
