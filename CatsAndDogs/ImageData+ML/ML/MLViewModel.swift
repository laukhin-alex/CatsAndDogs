//
//  MLViewModel.swift
//  CatsAndDogs
//
//  Created by Александр on 03.12.22.
//

import Foundation
import SwiftUI
import Vision

final class MLViewModelClassifier: ObservableObject {
    @Published var image = UIImage()
    private(set) var results: String?
    
    func detect(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: CatOrDogClassifier().model) else {
            print("No model")
            return
        }
        let request = VNCoreMLRequest(model: model)
        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(ciImage: ciImage)

        try? handler.perform([request])
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        parserValue(results: results)
    }
     func detect(cgImage: CGImage) {

        guard let model = try? VNCoreMLModel(for: CatOrDogClassifier(configuration: MLModelConfiguration()).model)
        else {
            return
        }

        let request = VNCoreMLRequest(model: model)
        request.imageCropAndScaleOption = .centerCrop

        let handler = VNImageRequestHandler(cgImage: cgImage)

        try? handler.perform([request])

        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }

        parserValue(results: results)

    }

     func detect(cvPixelBuffer: CVPixelBuffer) {

        guard let model = try? CatOrDogClassifier(configuration: MLModelConfiguration())
        else {
            return
        }

        if let prediction = try? model.prediction(image: cvPixelBuffer) {
            for classLabel in prediction.classLabelProbs {
                print(classLabel)
            }
        }

        guard let modelCoreML = try? VNCoreMLModel(for: model.model)
        else {
            return
        }

        let request = VNCoreMLRequest(model: modelCoreML)
        request.imageCropAndScaleOption = .centerCrop

        let handler = VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer)

        try? handler.perform([request])

        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        parserValue(results: results)
    }

    func parserValue (results: [VNClassificationObservation]) {
        if let firstResult = results.first {
            let formatted = String(format: "%.2f", firstResult.confidence * 100)
            self.results = "\(firstResult.identifier) \(formatted)%"
        }
    }

    func clear() {
        self.results = "N/A"
    }

}
