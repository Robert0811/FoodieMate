import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var classificationResult: String = ""
    @State private var caloriesInfo: String = ""
    @State private var showImagePicker = false

    let caloriesDict = FoodCalories.caloriesDict

    var body: some View {
        VStack(spacing: 20) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }

            Text("Prediction: \(classificationResult)")
                .padding()
                .font(.headline)
            
            if !caloriesInfo.isEmpty {
                Text("Estimated Calories: \(caloriesInfo) kcal")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }

            Button("Choose Image") {
                showImagePicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, classificationResult: $classificationResult, caloriesInfo: $caloriesInfo, caloriesDict: caloriesDict)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var classificationResult: String
    @Binding var caloriesInfo: String
    let caloriesDict: [String: Int]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            picker.dismiss(animated: true)
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
                if let cgImage = uiImage.cgImage {
                    MobileNetV2Classifier.shared?.classify(image: cgImage) { results in
                        if let topResult = results.first {
                            DispatchQueue.main.async {
                                let name = topResult.identifier
                                let confidence = Int(topResult.confidence * 100)
                                self.parent.classificationResult = "\(name) (\(confidence)%)"
                                if let cals = self.parent.caloriesDict[name.lowercased()] {
                                    self.parent.caloriesInfo = "\(cals)"
                                } else {
                                    self.parent.caloriesInfo = "N/A"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
