import SwiftUI

struct HomeView: View {
    @State private var showMenu = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        Text("🍽️ FoodieMate")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.orange)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)

                    VStack(spacing: 20) {
                        NavigationLink(destination: MealPlanView()) {
                            HomeButton(title: "Meal Plan", color: .orange, icon: "fork.knife")
                        }
                        NavigationLink(destination: CaloriesView()) {
                            HomeButton(title: "Calories", color: .red, icon: "flame")
                        }
                        NavigationLink(destination: ProfileDetailsView()) {
                            HomeButton(title: "Profile", color: .green, icon: "person.circle")
                        }
                        NavigationLink(destination: RecipesView()) {
                            HomeButton(title: "Recipes", color: .blue, icon: "book")
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .offset(x: showMenu ? 250 : 0)
                .disabled(showMenu)

                if showMenu {
                    SideMenu(showMenu: $showMenu)
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeButton: View {
    var title: String
    var color: Color
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(color.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: color.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}

struct SideMenu: View {
    @Binding var showMenu: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showMenu = false
                    }
                }

            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Robert Trifan")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(.top, 50)

                NavigationLink(destination: ProfileDetailsView()) {
                    Label("Profile Details", systemImage: "person")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: SettingsView()) {
                    Label("Settings", systemImage: "gear")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: AboutView()) {
                    Label("About", systemImage: "info.circle")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: ContactView()) {
                    Label("Contact", systemImage: "envelope")
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding()
            .frame(width: 250)
            .background(Color.white)
            .offset(x: 0)
            .transition(.move(edge: .leading))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
