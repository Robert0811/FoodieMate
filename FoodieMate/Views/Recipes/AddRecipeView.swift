import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var recipes: [Recipe]
    
    @State private var name = ""
    @State private var description = ""
    @State private var category: RecipeCategory = .breakfast
    @State private var ingredientsText = ""
    @State private var selectedImageData: Data? = nil
    @State private var photoPickerItem: PhotosPickerItem? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Info")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    Picker("Category", selection: $category) {
                        ForEach(RecipeCategory.allCases) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }
                
                Section(header: Text("Image")) {
                    PhotosPicker(selection: $photoPickerItem, matching: .images) {
                        if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .cornerRadius(10)
                        } else {
                            Text("Select Image")
                                .foregroundColor(.blue)
                        }
                    }
                    .onChange(of: photoPickerItem) {
                        Task {
                            if let data = try? await photoPickerItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                }
                
                Section(header: Text("Ingredients (comma-separated)")) {
                    TextField("e.g., 2 eggs, 1 cup milk", text: $ingredientsText)
                }
            }
            .navigationTitle("Add New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let ingredients = ingredientsText.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                        let newRecipe = Recipe(
                            name: name,
                            imageData: selectedImageData,
                            category: category,
                            description: description,
                            ingredients: ingredients
                        )
                        recipes.append(newRecipe)
                        dismiss()
                    }
                    .disabled(name.isEmpty || description.isEmpty || ingredientsText.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    
    struct AddRecipeView_Previews: PreviewProvider {
        static var previews: some View {
            AddRecipeView(recipes: .constant([]))
        }
    }
}

