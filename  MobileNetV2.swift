//
//   MobileNetV2.swift
//  FoodieMate
//
//  Created by Robert Trifan on 30.05.2025.
//

import CoreML
import Vision

@available(iOS 13.0, *)
class MobileNetV2Classifier {
    static let shared = MobileNetV2Classifier()
    private let model: VNCoreMLModel

    private init?() {
        guard let coreMLModel = try? MobileNetV2(configuration: MLModelConfiguration()).model,
              let visionModel = try? VNCoreMLModel(for: coreMLModel) else {
            return nil
        }
        self.model = visionModel
    }

    func classify(image: CGImage, completion: @escaping ([VNClassificationObservation]) -> Void) {
        let request = VNCoreMLRequest(model: self.model) { request, error in
            guard let results = request.results as? [VNClassificationObservation], error == nil else {
                completion([])
                return
            }
            completion(results)
        }

        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        try? handler.perform([request])
    }
}
