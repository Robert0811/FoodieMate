//
//  Recipe.swift
//  FoodieMate
//
//  Created by Robert Trifan on 31.05.2025.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id = UUID()
    let name: String
    let imageData: Data?
    let category: RecipeCategory
    let description: String
    let ingredients: [String]
}
