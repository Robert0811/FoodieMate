import SwiftUI
import Combine

class ThemeManager: ObservableObject {
    enum ThemeOption: String, CaseIterable, Identifiable {
        case light, dark, system
        var id: String { rawValue }
    }

    @Published var appearanceMode: ThemeOption = .system {
        didSet {
            saveAppearance()
        }
    }

    init() {
        loadAppearance()
    }

    func saveAppearance() {
        UserDefaults.standard.set(appearanceMode.rawValue, forKey: "appearanceMode")
    }

    func loadAppearance() {
        if let saved = UserDefaults.standard.string(forKey: "appearanceMode"),
           let mode = ThemeOption(rawValue: saved) {
            appearanceMode = mode
        } else {
            appearanceMode = .system
        }
    }
}
