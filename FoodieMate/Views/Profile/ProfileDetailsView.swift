import SwiftUI
import PhotosUI

struct ProfileDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("name") private var name = "Robert Trifan"
    @AppStorage("age") private var age = 23
    @AppStorage("height") private var height: Double = 178
    @AppStorage("weight") private var weight: Double = 130
    @AppStorage("gender") private var gender = "Male"
    @AppStorage("profilePicture") private var profilePicture = ""

    @State private var selectedEmoji = "🙂"
    let emojis = ["🙂", "😎", "👩‍💻", "👨‍💻", "🏋️‍♂️", "🏃‍♀️", "💪"]

    @State private var showImagePicker = false
    @State private var profileUIImage: UIImage?

    @State private var classificationResult: String = ""
    @State private var caloriesInfo: String = ""
    let caloriesDict = FoodCalories.caloriesDict

    @State private var showAbout = false
    @State private var showContact = false
    @State private var showProfileData = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                Text("Profile Details")
                    .font(.largeTitle.bold())
                    .foregroundColor(.orange)
                    .padding(.top, 40)

                // Butoane pentru alte view-uri
                HStack(spacing: 30) {
                    Button("About") {
                        showAbout.toggle()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Contact") {
                        showContact.toggle()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Profile Data") {
                        showProfileData.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.bottom, 20)

                // Profile Picture / Emoji
                VStack {
                    if profilePicture.isEmpty {
                        Text(selectedEmoji)
                            .font(.system(size: 80))
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)

                        Picker("Emoji", selection: $selectedEmoji) {
                            ForEach(emojis, id: \.self) { emoji in
                                Text(emoji)
                            }
                        }
                        .onChange(of: selectedEmoji) {
                            profilePicture = selectedEmoji
                        }
                        .padding()
                    } else {
                        Image(uiImage: loadImage(from: profilePicture))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }

                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Change Photo")
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(
                            selectedImage: $profileUIImage,
                            classificationResult: $classificationResult,
                            caloriesInfo: $caloriesInfo,
                            caloriesDict: caloriesDict
                        )
                        .onDisappear {
                            if let imageData = profileUIImage?.jpegData(compressionQuality: 0.8) {
                                let base64String = imageData.base64EncodedString()
                                profilePicture = base64String
                            }
                        }
                    }
                }

                // User Data
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Your Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Stepper("Age: \(age)", value: $age, in: 10...100)

                    HStack {
                        Text("Height: \(Int(height)) cm")
                        Slider(value: $height, in: 100...220, step: 1)
                            .accentColor(.green)
                    }

                    HStack {
                        Text("Weight: \(Int(weight)) kg")
                        Slider(value: $weight, in: 30...200, step: 1)
                            .accentColor(.purple)
                    }

                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationTitle("Profile Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                colors: [Color("ContactStart"), Color("ContactEnd")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )

        // Sheet-uri pentru celelalte view-uri
        .sheet(isPresented: $showAbout) {
            AboutView()
        }
        .sheet(isPresented: $showContact) {
            ContactView()
        }
        .sheet(isPresented: $showProfileData) {
        }
    }

    func loadImage(from string: String) -> UIImage {
        if let data = Data(base64Encoded: string), let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "person.crop.circle") ?? UIImage()
    }
}

#Preview {
    ProfileDetailsView()
}
