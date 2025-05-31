import SwiftUI

struct ProfileView: View {
    @State private var showAnimalPicker = false
    @State private var selectedAnimal = "panda"

    func animalName(_ key: String) -> String {
        switch key {
        case "panda": return "Bamboozle"
        case "urs": return "HoneyBuns"
        case "rata": return "Quackster"
        case "pisica": return "Whiskey"
        case "cappy": return "Cappy"
        case "alien": return "E.T."
        case "cangur": return "Hopping"
        case "yoda": return "Baby Yoda"
        case "groot": return "Groot"
        default: return "Unknown"
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button(action: {
                        showAnimalPicker.toggle()
                    }) {
                        Image(systemName: "pawprint")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.blue)
                            .background(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 2)
                                    .frame(width: 36, height: 36)
                            )
                    }
                    .sheet(isPresented: $showAnimalPicker) {
                        VStack(spacing: 20) {
                            Text(animalName(selectedAnimal))
                                .font(.largeTitle)
                                .bold()
                                .padding(.top)

                            Image(selectedAnimal)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("PrimaryStart"), Color("PrimaryEnd")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(20)
                                .shadow(radius: 10)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 30) {
                                    ForEach(["panda", "pisica", "cappy", "urs", "rata", "alien", "cangur", "yoda", "groot"], id: \.self) { animal in
                                        VStack {
                                            Image(animal)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 90, height: 90)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle().stroke(selectedAnimal == animal ? Color.orange : Color.clear, lineWidth: 3)
                                                        .scaleEffect(selectedAnimal == animal ? 1.15 : 1.0)
                                                        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedAnimal)
                                                )
                                                .scaleEffect(selectedAnimal == animal ? 1.15 : 1.0)
                                                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedAnimal)
                                                .onTapGesture {
                                                    withAnimation {
                                                        selectedAnimal = animal
                                                    }
                                                }

                                            Text(animalName(animal))
                                                .font(.caption)
                                                .padding(.top, 6)
                                        }
                                        .padding(8)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                            }

                            Spacer()
                        }
                        .padding()
                        .padding(.bottom, 50)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("PrimaryStart"), Color("PrimaryEnd")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(20)
                        .presentationDetents([.fraction(0.5)])
                    }

                    Spacer()
                }
                .padding(.top, -2)
                .padding(.leading, 20)

                VStack(spacing: 20) {
                    // Header data și calendar
                    VStack(spacing: 8) {
                        Text("Mai '25")
                            .font(.title2)
                            .bold()
                        Text("Vineri")
                            .foregroundColor(.gray)

                        let weekDays = Calendar.current.shortWeekdaySymbols

                        let calendar = Calendar.current
                        let today = Date()
                        let weekday = calendar.component(.weekday, from: today)
                        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - calendar.firstWeekday), to: today) ?? today

                        HStack(spacing: 10) {
                            ForEach(0..<7, id: \.self) { index in
                                let date = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
                                let daySymbol = weekDays[(calendar.component(.weekday, from: date) - 1) % 7].uppercased()
                                let dayNumber = calendar.component(.day, from: date)

                                VStack {
                                    Text(daySymbol)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                    Text("\(dayNumber)")
                                        .font(.headline)
                                        .foregroundColor(calendar.isDate(date, inSameDayAs: today) ? .orange : .primary)
                                }
                                .padding(6)
                                .background(calendar.isDate(date, inSameDayAs: today) ? Color.orange.opacity(0.2) : Color.clear)
                                .cornerRadius(8)
                            }
                        }

                        Image(selectedAnimal)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 360, height: 360)
                            .shadow(color: .white.opacity(0.9), radius: 8, x: 0, y: 0)
                            .padding(.vertical, 12)
                    }
                    .padding(.horizontal)

                    Text(animalName(selectedAnimal))
                        .font(.title)
                        .bold()

                    HStack(spacing: 30) {
                        VStack {
                            Text("Age")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("23")
                                .font(.title3)
                                .bold()
                        }
                        VStack {
                            Text("Height")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("178 cm")
                                .font(.title3)
                                .bold()
                        }
                        VStack {
                            Text("Weight")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("130 kg")
                                .font(.title3)
                                .bold()
                        }
                        VStack {
                            Text("Gender")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Male")
                                .font(.title3)
                                .bold()
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)

                    Spacer()
                }
                .padding()
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("PrimaryStart"), Color("PrimaryEnd")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    ProfileView()
}
