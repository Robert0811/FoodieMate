import SwiftUI

struct CaloriesView: View {
    @EnvironmentObject var dataManager: DataManager

    @State private var selectedMeal = "Breakfast"
    @State private var caloriesInputInt: Int = 0
    @State private var proteinInputInt: Int = 0
    @State private var carbsInputInt: Int = 0
    @State private var fatInputInt: Int = 0
    @State private var fiberInputInt: Int = 0
    
    @State private var showAddedAlert = false
    @State private var animateAddButton = false
    
    @State private var dailyCalorieIntake: Int = 2000
    
    let meals = ["Breakfast", "Lunch", "Dinner", "Snack"]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color("PrimaryStart"), Color("PrimaryEnd")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        // Header
                        Text("Calories Tracker")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)

                        // Total Consumption Circle
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.15))
                                .frame(width: 180, height: 180)
                                .shadow(color: Color.orange.opacity(0.6), radius: 15, x: 0, y: 12)

                            Circle()
                                .trim(from: 0, to: CGFloat(1 - progress))
                                .stroke(
                                    progressColor,
                                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                                )
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 180, height: 180)
                                .animation(.easeOut(duration: 1.0), value: progress)

                            VStack(spacing: 6) {
                                Text("\(max(dailyCalorieIntake - dataManager.totalConsumed, 0))")
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 4)
                                Text("kcal left")
                                    .font(.headline)
                                    .foregroundColor(Color.white.opacity(0.8))
                                    .tracking(2)
                            }
                        }
                        .padding(.vertical, 10)

                        // Daily Calorie Intake Input (slider)
                        VStack(spacing: 12) {
                            Text("Daily Calorie Intake")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)

                            Text("\(dailyCalorieIntake) kcal")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)

                            Slider(value: Binding(
                                get: { Double(dailyCalorieIntake) },
                                set: { newVal in dailyCalorieIntake = Int(newVal) }
                            ), in: 1000...4000, step: 50)
                            .accentColor(.orange)
                            .padding(.horizontal, 25)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)

                        // Nutrients Summary
                        HStack(spacing: 18) {
                            NutrientSummaryView(name: "Calories", value: String(dataManager.totalConsumed))
                            NutrientSummaryView(name: "Protein", value: "\(dataManager.protein) g")
                            NutrientSummaryView(name: "Carbs", value: "\(dataManager.carbs) g")
                            NutrientSummaryView(name: "Fat", value: "\(dataManager.fat) g")
                            NutrientSummaryView(name: "Fiber", value: "\(dataManager.fiber) g")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 14)
                        .background(.ultraThinMaterial)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 6)
                        .padding(.horizontal)

                        // Meals List (compact nutrient summary)
                        VStack(spacing: 18) {
                            ForEach(meals, id: \.self) { meal in
                                VStack(spacing: 6) {
                                    Text(meal)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.9))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    HStack(spacing: 15) {
                                        VStack(spacing: 2) {
                                            Text("\(dataManager.mealsNutrition[meal]?.calories ?? 0)")
                                                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Calories")
                                                .font(.caption2).foregroundColor(Color.white.opacity(0.7))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        VStack(spacing: 2) {
                                            Text("\(dataManager.mealsNutrition[meal]?.protein ?? 0) g")
                                                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Protein")
                                                .font(.caption2).foregroundColor(Color.white.opacity(0.7))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        VStack(spacing: 2) {
                                            Text("\(dataManager.mealsNutrition[meal]?.carbs ?? 0) g")
                                                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Carbs")
                                                .font(.caption2).foregroundColor(Color.white.opacity(0.7))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        VStack(spacing: 2) {
                                            Text("\(dataManager.mealsNutrition[meal]?.fat ?? 0) g")
                                                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Fat")
                                                .font(.caption2).foregroundColor(Color.white.opacity(0.7))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        VStack(spacing: 2) {
                                            Text("\(dataManager.mealsNutrition[meal]?.fiber ?? 0) g")
                                                .font(.subheadline).fontWeight(.bold).foregroundColor(.white)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            Text("Fiber")
                                                .font(.caption2).foregroundColor(Color.white.opacity(0.7))
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .background(Color.white.opacity(0.15))
                                    .cornerRadius(18)
                                }
                                .padding(.vertical, 2)
                                .background(.ultraThinMaterial)
                                .cornerRadius(18)
                                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.bottom, 15)

                        // Add Nutrition Form
                        VStack(spacing: 18) {
                            Text("Add Nutrition to Meal")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
                                .padding(.horizontal)

                            Picker("Select Meal", selection: $selectedMeal) {
                                ForEach(meals, id: \.self) { meal in
                                    Text(meal).tag(meal)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)

                            Group {
                                HStack(spacing: 24) {
                                    // Calories
                                    VStack(spacing: 8) {
                                        Text("\(caloriesInputInt)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .frame(minWidth: 38)
                                        HStack(spacing: 6) {
                                            Button(action: {
                                                if caloriesInputInt >= 10 { caloriesInputInt -= 10 }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Button(action: {
                                                if caloriesInputInt <= 1990 { caloriesInputInt += 10 }
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Text("kcal")
                                                .foregroundColor(.white.opacity(0.85))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        Text("Calories")
                                            .foregroundColor(.white.opacity(0.85))
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                    // Protein
                                    VStack(spacing: 8) {
                                        Text("\(proteinInputInt)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .frame(minWidth: 38)
                                        HStack(spacing: 6) {
                                            Button(action: {
                                                if proteinInputInt > 0 { proteinInputInt -= 1 }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Button(action: {
                                                if proteinInputInt < 200 { proteinInputInt += 1 }
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Text("g")
                                                .foregroundColor(.white.opacity(0.85))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        Text("Protein")
                                            .foregroundColor(.white.opacity(0.85))
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                    // Carbs
                                    VStack(spacing: 8) {
                                        Text("\(carbsInputInt)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .frame(minWidth: 38)
                                        HStack(spacing: 6) {
                                            Button(action: {
                                                if carbsInputInt > 0 { carbsInputInt -= 1 }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Button(action: {
                                                if carbsInputInt < 300 { carbsInputInt += 1 }
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Text("g")
                                                .foregroundColor(.white.opacity(0.85))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        Text("Carbs")
                                            .foregroundColor(.white.opacity(0.85))
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.horizontal)
                                HStack(spacing: 24) {
                                    // Fat
                                    VStack(spacing: 8) {
                                        Text("\(fatInputInt)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .frame(minWidth: 38)
                                        HStack(spacing: 6) {
                                            Button(action: {
                                                if fatInputInt > 0 { fatInputInt -= 1 }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Button(action: {
                                                if fatInputInt < 150 { fatInputInt += 1 }
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Text("g")
                                                .foregroundColor(.white.opacity(0.85))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        Text("Fat")
                                            .foregroundColor(.white.opacity(0.85))
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                    // Fiber
                                    VStack(spacing: 8) {
                                        Text("\(fiberInputInt)")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .frame(minWidth: 38)
                                        HStack(spacing: 6) {
                                            Button(action: {
                                                if fiberInputInt > 0 { fiberInputInt -= 1 }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Button(action: {
                                                if fiberInputInt < 100 { fiberInputInt += 1 }
                                            }) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.title3)
                                            }
                                            Text("g")
                                                .foregroundColor(.white.opacity(0.85))
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        Text("Fiber")
                                            .foregroundColor(.white.opacity(0.85))
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                                .padding(.horizontal)
                            }

                            Button(action: {
                                withAnimation(.spring()) {
                                    animateAddButton = true
                                    addNutrition()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    animateAddButton = false
                                }
                            }) {
                                Text("Add to \(selectedMeal)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(animateAddButton ? Color.orange.opacity(0.85) : Color.orange)
                                    .cornerRadius(20)
                                    .shadow(color: Color.orange.opacity(0.6), radius: 12, x: 0, y: 6)
                                    .scaleEffect(animateAddButton ? 1.05 : 1.0)
                            }
                            .padding(.horizontal)
                            .disabled(!isInputValid())
                            .opacity(isInputValid() ? 1 : 0.6)
                        }
                        .padding(.vertical, 15)
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Progresul consumului
    var progress: Double {
        guard dailyCalorieIntake > 0 else { return 0 }
        return min(Double(dataManager.totalConsumed) / Double(dailyCalorieIntake), 1.0)
    }
    
    // Culoarea marginii cercului în funcție de progres
    var progressColor: Color {
        switch progress {
        case 0..<0.5:
            return Color.green
        case 0.5..<0.85:
            return Color.yellow
        default:
            return Color.red
        }
    }
    
    func isInputValid() -> Bool {
        return caloriesInputInt > 0
    }

    func addNutrition() {
        let nutrition = MealNutrition(
            calories: caloriesInputInt,
            protein: proteinInputInt,
            carbs: carbsInputInt,
            fat: fatInputInt,
            fiber: fiberInputInt
        )
        dataManager.addMealNutrition(meal: selectedMeal, nutrition: nutrition)

        caloriesInputInt = 0
        proteinInputInt = 0
        carbsInputInt = 0
        fatInputInt = 0
        fiberInputInt = 0

        showAddedAlert = true
    }
}

struct NutrientSummaryView: View {
    var name: String
    var value: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .minimumScaleFactor(0.5)
                .lineLimit(1)

            Text(name)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(15)
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
        .frame(minWidth: 80, maxWidth: 100)
    }
}
