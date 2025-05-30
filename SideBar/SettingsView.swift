import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("notifications") private var notificationsEnabled = true
    @AppStorage("sounds") private var soundsEnabled = true
    @AppStorage("haptics") private var hapticsEnabled = true
    @AppStorage("language") private var language = "English"
    @AppStorage("dataSync") private var dataSyncEnabled = true

    var languages = ["English", "Română", "Deutsch", "Français", "Español"]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("ContactStart"), Color("ContactEnd")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("App Settings")
                        .font(.largeTitle.bold())
                        .foregroundColor(colorScheme == .dark ? Color.orange.opacity(0.9) : Color.orange)
                        .padding(.top, 50)

                    VStack(spacing: 20) {
                        Picker("Theme", selection: $themeManager.appearanceMode) {
                            ForEach(ThemeManager.ThemeOption.allCases) { mode in
                                Text(mode.rawValue.capitalized).tag(mode)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)

                        if themeManager.appearanceMode != .system {
                            Toggle(isOn: Binding(
                                get: { themeManager.appearanceMode == .dark },
                                set: { newValue in
                                    themeManager.appearanceMode = newValue ? .dark : .light
                                })) {
                                Label("Dark Mode", systemImage: "moon.fill")
                            }
                            .padding()
                            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        }

                        Toggle(isOn: $notificationsEnabled) {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                        Toggle(isOn: $soundsEnabled) {
                            Label("Sounds", systemImage: "speaker.wave.2.fill")
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                        Toggle(isOn: $hapticsEnabled) {
                            Label("Haptic Feedback", systemImage: "iphone.radiowaves.left.and.right")
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                        Picker("Language", selection: $language) {
                            ForEach(languages, id: \.self) { lang in
                                Text(lang)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                        Toggle(isOn: $dataSyncEnabled) {
                            Label("Data Sync", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                        Button(action: {
                            // Reset data logic here
                        }) {
                            Label("Reset App Data", systemImage: "trash")
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 20) {
                        NavigationLink(destination: AboutView()) {
                            Label("About", systemImage: "info.circle")
                                .foregroundColor(colorScheme == .dark ? Color.orange.opacity(0.9) : Color.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }
                        NavigationLink(destination: ContactView()) {
                            Label("Contact", systemImage: "phone.circle")
                                .foregroundColor(colorScheme == .dark ? Color.orange.opacity(0.9) : Color.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }
                        NavigationLink(destination: ProfileDetailsView()) {
                            Label("Profile Details", systemImage: "person.crop.circle")
                                .foregroundColor(colorScheme == .dark ? Color.orange.opacity(0.9) : Color.orange)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
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
        .preferredColorScheme(
            themeManager.appearanceMode == .system ? nil :
            (themeManager.appearanceMode == .light ? .light : .dark)
        )
    }
}

#Preview {
    SettingsView()
}
