import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 2 // Pornim pe tabul Profile
    @State private var showSettings = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    MealPlanView()
                        .tabItem {
                            VStack {
                                Image(systemName: "fork.knife")
                                Text("Meal Plan")
                            }
                        }
                        .tag(0)
                    
                    CaloriesView()
                        .tabItem {
                            VStack {
                                Image(systemName: "flame")
                                Text("Calories")
                            }
                        }
                        .tag(1)
                    
                    ProfileView()
                        .tabItem {
                            VStack {
                                Image(systemName: "person.circle")
                                Text("Profile")
                            }
                        }
                        .tag(2)
                    
                    RecipesView()
                        .tabItem {
                            VStack {
                                Image(systemName: "book")
                                Text("Recipes")
                            }
                        }
                        .tag(3)
                    
                    ContentView()
                        .tabItem {
                            VStack {
                                Image(systemName: "camera")
                                Text("Food Classifier")
                            }
                        }
                        .tag(4)
                }
                .accentColor(.orange)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("PrimaryStart"),
                            Color("PrimaryEnd")
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.95)
                    .ignoresSafeArea(edges: .bottom)
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color("PrimaryStart"))
                    }
                    .padding(.bottom, 8)
                    .contentShape(Rectangle())
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .preferredColorScheme(.light)
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
