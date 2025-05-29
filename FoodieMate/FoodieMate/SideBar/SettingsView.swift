import SwiftUI

struct SettingsView: View {
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("notifications") private var notificationsEnabled = true
    @AppStorage("sounds") private var soundsEnabled = true
    @AppStorage("haptics") private var hapticsEnabled = true
    @AppStorage("language") private var language = "English"
    @AppStorage("dataSync") private var dataSyncEnabled = true

    var languages = ["English", "Română", "Deutsch", "Français", "Español"]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("App Settings")
                    .font(.largeTitle.bold())
                    .foregroundColor(.orange)
                    .padding(.top, 50)

                VStack(spacing: 20) {
                    Toggle(isOn: $darkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Toggle(isOn: $soundsEnabled) {
                        Label("Sounds", systemImage: "speaker.wave.2.fill")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Toggle(isOn: $hapticsEnabled) {
                        Label("Haptic Feedback", systemImage: "iphone.radiowaves.left.and.right")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Picker("Language", selection: $language) {
                        ForEach(languages, id: \.self) { lang in
                            Text(lang)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Toggle(isOn: $dataSyncEnabled) {
                        Label("Data Sync", systemImage: "arrow.triangle.2.circlepath")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    Button(action: {
                        // Reset data logic here
                    }) {
                        Label("Reset App Data", systemImage: "trash")
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
