import SwiftUI

struct CaloriesView: View {
    // Exemplu date (temporar)
    @AppStorage("dailyCalorieGoal") private var dailyCalorieGoal = 3000
    @AppStorage("totalConsumed") private var totalConsumed = 0
    @State private var exerciseBurn = 10
    @AppStorage("protein") private var protein = 15
    @AppStorage("carbs") private var carbs = 11
    @AppStorage("fat") private var fat = 20
    @AppStorage("fiber") private var Fiber = 20
    @AppStorage("mealCaloriesBreakfast") private var mealCaloriesBreakfast = 0
    @AppStorage("mealCaloriesLunch") private var mealCaloriesLunch = 0
    @AppStorage("mealCaloriesDinner") private var mealCaloriesDinner = 0
    @AppStorage("mealCaloriesSnack") private var mealCaloriesSnack = 0
    @State private var showSettings = false
    @State private var showLogMeal = false
    @State private var logMealCalories = ""
    @State private var currentMeal: String = ""

    var caloriesLeft: Int {
        dailyCalorieGoal - totalConsumed
    }

    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.98, blue: 0.95).ignoresSafeArea() // off-white/cream background

            VStack(spacing: 10) {
                // Header
                HStack {
                    Spacer()
                    Text("Today")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showSettings) {
                        VStack(spacing: 20) {
                            Text("Edit Daily Calorie Goal")
                                .font(.largeTitle.bold())
                                .foregroundColor(.orange)
                                .padding()

                            Text("Adjust the total calories you want to consume in a day.")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            Stepper(value: $dailyCalorieGoal, in: 1000...5000, step: 100) {
                                Text("Calories: \(dailyCalorieGoal) kcal")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(15)
                            .shadow(radius: 5)

                            Button(action: {
                                showSettings = false
                            }) {
                                Text("Save")
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .cornerRadius(15)
                                    .shadow(color: Color.orange.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.white, Color.orange.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 40)

                // Can Eat Section
                VStack(spacing: 10) {
                    Text("Can Eat")
                        .font(.headline)
                        .foregroundColor(.gray)
                    let progress = max(0, min(1, CGFloat(caloriesLeft) / CGFloat(dailyCalorieGoal)))
                    ZStack {
                        Circle()
                            .stroke(Color.orange.opacity(0.3), lineWidth: 25)
                            .frame(width: 210, height: 190)

                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(progress > 0.5 ? Color.green : (progress > 0.2 ? Color.yellow : Color.red), style: StrokeStyle(lineWidth: 25, lineCap: .round))
                            .frame(width: 190, height: 190)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: progress)

                        Text("\(caloriesLeft)")
                            .font(.system(size: 44, weight: .bold, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .shadow(color: Color.orange.opacity(0.3), radius: 15, x: 0, y: 0)

                    Text("\(caloriesLeft) kcal left / \(dailyCalorieGoal) kcal goal")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(Color(.systemBackground))
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)

                // Macronutrients
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        NutrientBar(title: "Protein", value: protein, maxValue: 210, color: .green)
                        NutrientBar(title: "Carbs", value: carbs, maxValue: 350, color: .blue)
                    }
                    HStack(spacing: 20) {
                        NutrientBar(title: "Fat", value: fat, maxValue: 70, color: .purple)
                        NutrientBar(title: "Fiber", value: Fiber, maxValue: 34, color: .mint)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                .padding(.horizontal)

                // Food Intake List
                VStack(alignment: .leading, spacing: 20) {
                    Text("Food Intake")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)

                    ForEach(["Breakfast", "Lunch", "Dinner", "Snack"], id: \.self) { meal in
                        HStack(spacing: 16) {
                            Image(systemName: iconName(for: meal))
                                .font(.title2)
                                .foregroundColor(.orange)
                                .frame(width: 40, height: 40)
                                .background(Color.orange.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Text(meal)
                                .font(.headline)
                                .foregroundColor(.black)
                            Spacer()
                            let mealCal: Int = {
                                switch meal {
                                    case "Breakfast": return mealCaloriesBreakfast
                                    case "Lunch": return mealCaloriesLunch
                                    case "Dinner": return mealCaloriesDinner
                                    case "Snack": return mealCaloriesSnack
                                    default: return 0
                                }
                            }()
                            if mealCal > 0 {
                                Text("\(mealCal) kcal")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Button(action: {
                                    totalConsumed -= mealCal
                                    switch meal {
                                        case "Breakfast": mealCaloriesBreakfast = 0
                                        case "Lunch": mealCaloriesLunch = 0
                                        case "Dinner": mealCaloriesDinner = 0
                                        case "Snack": mealCaloriesSnack = 0
                                        default: break
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding(.leading, 4)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            Button(action: {
                                currentMeal = meal
                                showLogMeal = true
                            }) {
                                Text("+ Log")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.orange)
                                    .cornerRadius(15)
                                    .shadow(color: Color.orange.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 5)
                        .padding(.horizontal)
                    }
                }
                Spacer()
                .sheet(isPresented: $showLogMeal) {
                    VStack(spacing: 25) {
                        Text("Log Meal")
                            .font(.largeTitle.bold())
                            .foregroundColor(.orange)
                            .padding(.top, 20)

                        Text("Enter the calories for this meal")
                            .font(.body)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        TextField("Calories", text: $logMealCalories)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            .padding(.horizontal, 40)

                        Button(action: {
                            if let calories = Int(logMealCalories) {
                                totalConsumed += calories
                                switch currentMeal {
                                    case "Breakfast": mealCaloriesBreakfast += calories
                                    case "Lunch": mealCaloriesLunch += calories
                                    case "Dinner": mealCaloriesDinner += calories
                                    case "Snack": mealCaloriesSnack += calories
                                    default: break
                                }
                            }
                            showLogMeal = false
                            logMealCalories = ""
                        }) {
                            Text("Add Meal")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(15)
                                .shadow(color: Color.orange.opacity(0.5), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 40)

                        Spacer()
                    }
                    .background(Color(.systemBackground))
                }
            }
        }
    }

    private func iconName(for meal: String) -> String {
        switch meal {
        case "Breakfast": return "sunrise.fill"
        case "Lunch": return "sun.max.fill"
        case "Dinner": return "moon.stars.fill"
        case "Snack": return "leaf.fill"
        default: return "fork.knife"
        }
    }
}

struct NutrientBar: View {
    var title: String
    var value: Int
    var maxValue: Int
    var color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(title): \(value)/\(maxValue)g")
                .font(.subheadline)
                .foregroundColor(.black)
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 16)
                    .foregroundColor(color.opacity(0.15))
                Capsule()
                    .frame(width: CGFloat(value) / CGFloat(maxValue) * 140, height: 16)
                    .foregroundColor(color)
                    .shadow(color: color.opacity(0.5), radius: 4, x: 0, y: 2)
            }
            .frame(maxWidth: 140)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: color.opacity(0.15), radius: 8, x: 0, y: 4)
    }
}

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView()
    }
}
