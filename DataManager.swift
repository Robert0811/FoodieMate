import Foundation
import CloudKit

struct MealNutrition: Codable {
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var fiber: Int

    static var empty: MealNutrition {
        return MealNutrition(calories: 0, protein: 0, carbs: 0, fat: 0, fiber: 0)
    }
}

final class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var dailyCalorieGoal: Int = 2500
    @Published var totalConsumed: Int = 0
    @Published var protein: Int = 0
    @Published var carbs: Int = 0
    @Published var fat: Int = 0
    @Published var fiber: Int = 0
    
    // Folosim acum un dicționar pentru toate macronutrientele pe fiecare masă
    @Published var mealsNutrition: [String: MealNutrition] = [
        "Breakfast": .empty,
        "Lunch": .empty,
        "Dinner": .empty,
        "Snack": .empty
    ]
    
    @Published var weeklyCaloriesData: [DailyCalories] = []
    
    @Published var weight: Double = 0.0
    @Published var height: Double = 0.0
    @Published var age: Int = 0
    @Published var gender: String = ""
    @Published var name: String = ""
    @Published var profileImage: Data? = nil
    @Published var weightEntries: [Double] = []

    private let mealsKey = "mealsNutrition"
    private let weightKey = "weight"
    private let heightKey = "height"
    private let ageKey = "age"
    private let genderKey = "gender"
    private let nameKey = "name"
    private let profileImageKey = "profileImage"

    init() {
        loadCalorieData()
    }

    func saveCalorieData() {
        do {
            let data = try JSONEncoder().encode(mealsNutrition)
            UserDefaults.standard.set(data, forKey: mealsKey)
            UserDefaults.standard.set(weight, forKey: weightKey)
            UserDefaults.standard.set(height, forKey: heightKey)
            UserDefaults.standard.set(age, forKey: ageKey)
            UserDefaults.standard.set(gender, forKey: genderKey)
            UserDefaults.standard.set(name, forKey: nameKey)
            if let img = profileImage {
                UserDefaults.standard.set(img, forKey: profileImageKey)
            }
        } catch {
            print("Failed to save mealsNutrition: \(error)")
        }
    }

    func loadCalorieData() {
        if let data = UserDefaults.standard.data(forKey: mealsKey) {
            do {
                let decoded = try JSONDecoder().decode([String: MealNutrition].self, from: data)
                mealsNutrition = decoded
                recalcTotalNutrition()
            } catch {
                print("Failed to decode mealsNutrition: \(error)")
            }
        }
        weight = UserDefaults.standard.double(forKey: weightKey)
        height = UserDefaults.standard.double(forKey: heightKey)
        age = UserDefaults.standard.integer(forKey: ageKey)
        gender = UserDefaults.standard.string(forKey: genderKey) ?? ""
        name = UserDefaults.standard.string(forKey: nameKey) ?? ""
        profileImage = UserDefaults.standard.data(forKey: profileImageKey)
    }

    // Adaugă nutriția unei mese
    func addMealNutrition(meal: String, nutrition: MealNutrition) {
        if var current = mealsNutrition[meal] {
            current.calories += nutrition.calories
            current.protein += nutrition.protein
            current.carbs += nutrition.carbs
            current.fat += nutrition.fat
            current.fiber += nutrition.fiber
            mealsNutrition[meal] = current
        } else {
            mealsNutrition[meal] = nutrition
        }
        recalcTotalNutrition()
        saveCalorieData()
    }

    // Adaugă un produs la o masă
    func addProductToMeal(meal: String, productNutrition: MealNutrition) {
        if var current = mealsNutrition[meal] {
            current.calories += productNutrition.calories
            current.protein += productNutrition.protein
            current.carbs += productNutrition.carbs
            current.fat += productNutrition.fat
            current.fiber += productNutrition.fiber
            mealsNutrition[meal] = current
        } else {
            mealsNutrition[meal] = productNutrition
        }
        recalcTotalNutrition()
        saveCalorieData()
    }

    // Elimină toată nutriția unei mese
    func removeMealNutrition(for meal: String) {
        if let removed = mealsNutrition[meal] {
            totalConsumed -= removed.calories
            protein -= removed.protein
            carbs -= removed.carbs
            fat -= removed.fat
            fiber -= removed.fiber
            mealsNutrition[meal] = nil
            saveCalorieData()
        }
    }

    // Recalculează totalurile după modificări
    func recalcTotalNutrition() {
        protein = mealsNutrition.values.reduce(0) { $0 + $1.protein }
        carbs = mealsNutrition.values.reduce(0) { $0 + $1.carbs }
        fat = mealsNutrition.values.reduce(0) { $0 + $1.fat }
        fiber = mealsNutrition.values.reduce(0) { $0 + $1.fiber }
        totalConsumed = mealsNutrition.values.reduce(0) { $0 + $1.calories }
    }

    func addWeightEntry(_ weight: Double) {
        self.weight = weight
        self.weightEntries.append(weight)
        saveCalorieData()
    }

    func saveProfileImage(_ data: Data) {
        self.profileImage = data
        saveCalorieData()
    }

    func updateProfile(name: String, age: Int, height: Double, weight: Double, gender: String) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.gender = gender
        saveCalorieData()
    }

    func generateWeeklyCaloriesData() {
        if weeklyCaloriesData.isEmpty {
            let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            weeklyCaloriesData = days.map { day in
                let calories = Int.random(in: 1800...2500)
                return DailyCalories(date: Date(), calories: calories)
            }
        }
    }

    func saveDailyCalories(_ dailyCalories: DailyCalories) {
        // CloudKit functionality - commented out
    }

    func fetchDailyCalories() {
        // CloudKit functionality - commented out
    }

    // Returnează caloriile pentru o masă (pentru compatibilitate)
    func caloriesForMeal(_ meal: String) -> Int {
        return mealsNutrition[meal]?.calories ?? 0
    }
}
