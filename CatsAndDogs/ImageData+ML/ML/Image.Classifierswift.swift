//
//  Image.Classifierswift.swift
//  CatsAndDogs
//
//  Created by Александр on 03.12.22.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    @Published private var classifier = MLViewModelClassifier()

    var imageClass: String? {
        classifier.results
    }

    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }

    func detect(cgImage: CGImage) {
        classifier.detect(cgImage: cgImage)
    }

    func detect(cvPixelBuffer: CVPixelBuffer?) {
        if cvPixelBuffer != nil {
            classifier.detect(cvPixelBuffer: cvPixelBuffer!)
        }
    }
    func clear() {
        classifier.clear()
    }

}
