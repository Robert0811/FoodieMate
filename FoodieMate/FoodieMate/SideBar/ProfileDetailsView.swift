//
//  ProfileDetailsView.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//



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

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {

                Text("Profile Details")
                    .font(.largeTitle.bold())
                    .foregroundColor(.orange)
                    .padding(.top, 40)

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
                        .pickerStyle(.segmented)
                        .onChange(of: selectedEmoji) { newValue in
                            profilePicture = newValue
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
                        ImagePicker(selectedImage: $profileUIImage)
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
        .background(Color(red: 1.0, green: 0.98, blue: 0.95).ignoresSafeArea())
    }

    func loadImage(from string: String) -> UIImage {
        if let data = Data(base64Encoded: string), let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "person.crop.circle") ?? UIImage()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

#Preview {
    ProfileDetailsView()
}
