import SwiftUI

@main
struct FoodieMateApp: App {
    @StateObject private var dataManager = DataManager()
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(dataManager)
                .environmentObject(themeManager)
                .preferredColorScheme(
                    themeManager.appearanceMode == .system ? nil :
                    (themeManager.appearanceMode == .light ? .light : .dark)
                )
        }
    }
}
