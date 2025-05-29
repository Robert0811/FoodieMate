import SwiftUI

struct ProfileView: View {
    @AppStorage("name") private var name = "Robert Trifan"
    @AppStorage("age") private var age = 23
    @AppStorage("height") private var height: Double = 178
    @AppStorage("weight") private var weight: Double = 130

    @State private var weightEntries: [Double] = [125.5, 124, 123.5, 124, 125]
    @State private var selectedDate = Date()

    var bmi: Double {
        weight / ((height / 100) * (height / 100))
    }

    var bmiStatus: String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<24.9: return "Normal"
        case 24.9..<29.9: return "Overweight"
        case 29.9..<40: return "Obese"
        default: return "Severely Obese"
        }
    }

    var bmiColor: Color {
        switch bmi {
        case ..<18.5: return .blue
        case 18.5..<24.9: return .green
        case 24.9..<29.9: return .yellow
        case 29.9..<40: return .orange
        default: return .red
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                    Spacer()
                    Text("Profile")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    Spacer().frame(width: 30)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                // Info Card
                VStack(alignment: .leading, spacing: 15) {
                    Text("Your Info")
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Name:")
                        Spacer()
                        TextField("Your Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 180)
                    }
                    HStack {
                        Text("Age:")
                        Spacer()
                        Stepper("\(age) years", value: $age, in: 10...100)
                    }
                    HStack {
                        Text("Height:")
                        Spacer()
                        Slider(value: $height, in: 100...220, step: 1)
                            .accentColor(.green)
                        Text("\(Int(height)) cm")
                    }
                    HStack {
                        Text("Weight:")
                        Spacer()
                        Slider(value: $weight, in: 30...200, step: 1)
                            .accentColor(.purple)
                        Text("\(Int(weight)) kg")
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                // BMI Bar
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("BMI: \(String(format: "%.1f", bmi))")
                            .font(.title.bold())
                            .foregroundColor(bmiColor)
                        Spacer()
                        Text(bmiStatus)
                            .fontWeight(.semibold)
                            .foregroundColor(bmiColor)
                    }
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .green, .yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing))
                            .frame(height: 14)
                            .opacity(0.3)
                        Capsule()
                            .fill(bmiColor)
                            .frame(width: CGFloat(min(bmi / 40, 1)) * 300, height: 14)
                            .animation(.easeInOut, value: bmi)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                // Weight Tracker
                VStack(alignment: .leading, spacing: 12) {
                    Text("Weight Tracker")
                        .font(.title2)
                        .fontWeight(.semibold)
                    ChartView(weights: weightEntries)

                    Button(action: {
                        weightEntries.append(weight)
                    }) {
                        Text("Add Current Weight")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(15)
                            .shadow(color: Color.orange.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.bottom, 60)
        }
        .background(Color(red: 1.0, green: 0.98, blue: 0.95).ignoresSafeArea())
    }
}

struct ChartView: View {
    var weights: [Double]

    var body: some View {
        GeometryReader { geo in
            Path { path in
                for (index, value) in weights.enumerated() {
                    let x = geo.size.width / CGFloat(weights.count - 1) * CGFloat(index)
                    let y = geo.size.height - (CGFloat(value - 85) / 55) * geo.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.green, lineWidth: 3)
        }
        .frame(height: 150)
        .padding(.vertical, 10)
    }
}

#Preview {
    ProfileView()
}
