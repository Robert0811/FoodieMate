import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let category: RecipeCategory
    let description: String
    let ingredients: [String]
}

enum RecipeCategory: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
}

struct RecipesView: View {
    @State private var searchText = ""
    @State private var selectedCategory: RecipeCategory = .breakfast
    @State private var selectedRecipe: Recipe? = nil

    @State private var recipes: [Recipe] = [
        // Breakfast (existing + new)
        Recipe(
            name: "Avocado Toast",
            imageName: "avocado_toast",
            category: .breakfast,
            description: "Delicious and healthy avocado toast, perfect for a quick breakfast.",
            ingredients: [
                "2 slices whole grain bread",
                "1 ripe avocado (about 150g)",
                "Salt and pepper to taste",
                "1 tsp lemon juice",
                "Optional: chili flakes or cherry tomatoes"
            ]),
        Recipe(
            name: "Oatmeal Bowl",
            imageName: "oatmeal_bowl",
            category: .breakfast,
            description: "Warm oatmeal topped with fresh fruits and nuts for a nutritious start.",
            ingredients: [
                "1 cup rolled oats",
                "2 cups water or milk",
                "1/2 cup blueberries",
                "1 tbsp almonds",
                "1 tsp honey"
            ]),
        Recipe(
            name: "Berry Smoothie",
            imageName: "smoothie",
            category: .breakfast,
            description: "A refreshing smoothie loaded with antioxidants and vitamins.",
            ingredients: [
                "1/2 cup strawberries",
                "1/2 cup blueberries",
                "1 banana",
                "1 cup almond milk",
                "1 tbsp chia seeds"
            ]),

        // New Breakfast recipes
        Recipe(
            name: "Greek Yogurt Parfait",
            imageName: "greek_yogurt_parfait",
            category: .breakfast,
            description: "Layers of Greek yogurt, fresh berries, and granola for a protein-packed start.",
            ingredients: [
                "1 cup Greek yogurt",
                "1/2 cup mixed berries",
                "1/4 cup granola",
                "1 tbsp honey"
            ]),
        Recipe(
            name: "Chia Seed Pudding",
            imageName: "chia_seed_pudding",
            category: .breakfast,
            description: "Creamy pudding made with chia seeds soaked overnight in almond milk.",
            ingredients: [
                "3 tbsp chia seeds",
                "1 cup almond milk",
                "1 tsp vanilla extract",
                "1 tbsp maple syrup",
                "Fresh fruit for topping"
            ]),
        Recipe(
            name: "Spinach and Feta Omelette",
            imageName: "spinach_feta_omelette",
            category: .breakfast,
            description: "Protein-rich omelette with fresh spinach and tangy feta cheese.",
            ingredients: [
                "3 eggs",
                "1 cup fresh spinach",
                "1/4 cup crumbled feta cheese",
                "Salt and pepper to taste",
                "1 tbsp olive oil"
            ]),

        // Lunch (existing + new)
        Recipe(
            name: "Grilled Chicken Salad",
            imageName: "grilled_chicken_salad",
            category: .lunch,
            description: "Protein-packed grilled chicken served on a bed of fresh greens.",
            ingredients: [
                "150g grilled chicken breast",
                "Mixed greens",
                "Cherry tomatoes",
                "Cucumber slices",
                "Balsamic vinaigrette"
            ]),
        Recipe(
            name: "Quinoa Salad",
            imageName: "quinoa_salad",
            category: .lunch,
            description: "Light and tasty quinoa salad with fresh veggies and herbs.",
            ingredients: [
                "1 cup cooked quinoa",
                "1/2 cup diced cucumber",
                "1/2 cup diced tomato",
                "1/4 cup chopped parsley",
                "1 tbsp olive oil"
            ]),
        Recipe(
            name: "Veggie Stir Fry",
            imageName: "veggie_stir_fry",
            category: .lunch,
            description: "Colorful vegetables stir-fried with garlic and soy sauce.",
            ingredients: [
                "Broccoli florets",
                "Bell peppers",
                "Snap peas",
                "2 cloves garlic",
                "1 tbsp soy sauce"
            ]),

        // New Lunch recipes
        Recipe(
            name: "Lentil Soup",
            imageName: "lentil_soup",
            category: .lunch,
            description: "Hearty and nutritious lentil soup packed with vegetables and spices.",
            ingredients: [
                "1 cup lentils",
                "1 carrot, diced",
                "1 celery stalk, diced",
                "1 onion, chopped",
                "2 cloves garlic",
                "4 cups vegetable broth",
                "1 tsp cumin",
                "Salt and pepper to taste"
            ]),
        Recipe(
            name: "Turkey Wrap",
            imageName: "turkey_wrap",
            category: .lunch,
            description: "Whole wheat wrap filled with lean turkey, veggies, and hummus.",
            ingredients: [
                "1 whole wheat wrap",
                "100g sliced turkey breast",
                "Lettuce leaves",
                "Sliced tomato",
                "2 tbsp hummus"
            ]),
        Recipe(
            name: "Chickpea Salad",
            imageName: "chickpea_salad",
            category: .lunch,
            description: "Refreshing chickpea salad with cucumber, tomatoes, and herbs.",
            ingredients: [
                "1 cup chickpeas",
                "1/2 cup diced cucumber",
                "1/2 cup diced tomatoes",
                "1/4 cup chopped parsley",
                "1 tbsp lemon juice",
                "1 tbsp olive oil"
            ]),

        // Dinner (existing + new)
        Recipe(
            name: "Spaghetti Bolognese",
            imageName: "spaghetti_bolognese",
            category: .dinner,
            description: "Classic Italian pasta with a hearty meat sauce.",
            ingredients: [
                "150g lean ground beef",
                "1 cup tomato sauce",
                "200g whole wheat spaghetti",
                "1/2 onion, diced",
                "2 cloves garlic"
            ]),
        Recipe(
            name: "Baked Salmon",
            imageName: "baked_salmon",
            category: .dinner,
            description: "Oven-baked salmon rich in omega-3 fatty acids.",
            ingredients: [
                "150g salmon fillet",
                "Lemon slices",
                "Salt and pepper",
                "Fresh dill"
            ]),
        Recipe(
            name: "Veggie Chili",
            imageName: "veggie_chili",
            category: .dinner,
            description: "Hearty chili packed with beans and vegetables.",
            ingredients: [
                "1 cup black beans",
                "1 cup kidney beans",
                "1 cup diced tomatoes",
                "1 bell pepper",
                "Chili powder"
            ]),

        // New Dinner recipes
        Recipe(
            name: "Grilled Tofu Steaks",
            imageName: "grilled_tofu",
            category: .dinner,
            description: "Marinated tofu steaks grilled to perfection with herbs.",
            ingredients: [
                "200g firm tofu",
                "2 tbsp soy sauce",
                "1 tbsp olive oil",
                "1 tsp smoked paprika",
                "Fresh parsley"
            ]),
        Recipe(
            name: "Roasted Vegetable Medley",
            imageName: "roasted_vegetables",
            category: .dinner,
            description: "A mix of roasted seasonal vegetables with olive oil and herbs.",
            ingredients: [
                "1 zucchini, sliced",
                "1 bell pepper, chopped",
                "1 eggplant, sliced",
                "1 red onion, sliced",
                "2 tbsp olive oil",
                "Salt and pepper"
            ]),
        Recipe(
            name: "Quinoa Stuffed Peppers",
            imageName: "quinoa_stuffed_peppers",
            category: .dinner,
            description: "Bell peppers stuffed with quinoa, black beans, and veggies.",
            ingredients: [
                "3 bell peppers",
                "1 cup cooked quinoa",
                "1/2 cup black beans",
                "1/2 cup corn",
                "1/2 cup diced tomatoes",
                "1 tsp cumin",
                "Salt and pepper"
            ]),

        // Snacks (existing + new)
        Recipe(
            name: "Fruit Salad",
            imageName: "fruit_salad",
            category: .snack,
            description: "A mix of fresh seasonal fruits, perfect for a healthy snack.",
            ingredients: [
                "1 cup watermelon",
                "1 cup strawberries",
                "1 banana",
                "1/2 cup grapes"
            ]),
        Recipe(
            name: "Granola Bar",
            imageName: "granola_bar",
            category: .snack,
            description: "Homemade granola bars with oats, nuts, and honey.",
            ingredients: [
                "2 cups rolled oats",
                "1/2 cup almonds",
                "1/4 cup honey",
                "1/4 cup peanut butter"
            ]),
        Recipe(
            name: "Hummus",
            imageName: "hummus_plate",
            category: .snack,
            description: "Creamy chickpea spread served with fresh veggies.",
            ingredients: [
                "1 cup chickpeas",
                "2 tbsp tahini",
                "1 clove garlic",
                "1 tbsp olive oil",
                "Lemon juice"
            ]),
        // New Snacks recipes
        Recipe(
            name: "Almond Energy Balls",
            imageName: "almond_energy_balls",
            category: .snack,
            description: "No-bake energy balls made with almonds, dates, and cocoa powder.",
            ingredients: [
                "1 cup almonds",
                "1 cup dates",
                "2 tbsp cocoa powder",
                "1 tbsp coconut oil"
            ]),
        Recipe(
            name: "Veggie Sticks with Guacamole",
            imageName: "veggie_sticks_guacamole",
            category: .snack,
            description: "Fresh veggie sticks served with homemade guacamole dip.",
            ingredients: [
                "Carrot sticks",
                "Celery sticks",
                "Cucumber sticks",
                "1 ripe avocado",
                "1 tbsp lime juice",
                "Salt and pepper"
            ]),
        Recipe(
            name: "Chia Pudding Cups",
            imageName: "chia_pudding_cups",
            category: .snack,
            description: "Individual chia pudding cups topped with fresh fruit and nuts.",
            ingredients: [
                "3 tbsp chia seeds",
                "1 cup coconut milk",
                "1 tsp vanilla extract",
                "Fresh berries",
                "Almonds"
            ])
    ]

    var filteredRecipes: [Recipe] {
        let filteredByCategory = recipes.filter { $0.category == selectedCategory }
        if searchText.isEmpty {
            return filteredByCategory
        } else {
            return filteredByCategory.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("PrimaryStart"), Color("PrimaryEnd")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Recipes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)

                Picker("Category", selection: $selectedCategory) {
                    ForEach(RecipeCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                TextField("Search recipes...", text: $searchText)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .foregroundColor(.primary)

                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredRecipes) { recipe in
                            Button {
                                selectedRecipe = recipe
                            } label: {
                                HStack(spacing: 15) {
                                    Image(recipe.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)

                                    Text(recipe.name)
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Spacer()
                                }
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .sheet(item: $selectedRecipe) { recipe in
                    RecipeDetailView(recipe: recipe)
                }

                Button(action: {
                    // Logic to add new recipe
                }) {
                    Text("Add New Recipe")
                        .foregroundColor(Color("PrimaryEnd"))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)

                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    Text(recipe.description)
                        .font(.body)
                        .padding(.horizontal)

                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Text("• \(ingredient)")
                                .font(.body)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("PrimaryStart"), Color("PrimaryEnd")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
