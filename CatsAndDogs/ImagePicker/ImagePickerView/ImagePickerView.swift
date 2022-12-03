//
//  ImagePickerView.swift
//  CatsAndDogs
//
//  Created by Александр on 03.12.22.
//

import SwiftUI

struct ImagePickerView: View {

    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var text = "Пока пусто"
    @ObservedObject var imageClassifier: ImageClassifier

    var body: some View {
        VStack {
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
            //            Group {
            //                if let imageClass = imageClassifier.imageClass {
            HStack {
                Text("Группа:")
                Text(text)
                //                    }
            }
            //            }
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight:  50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }

        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                .onDisappear {
                    text = imageClassifier.imageClass ?? "Пока пусто"
                    imageClassifier.detect(uiImage: image)
                    imageClassifier.detect(cvPixelBuffer: image.ciImage?.pixelBuffer)
                    print(imageClassifier.imageClass ?? "")
                }
        }
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView(imageClassifier: ImageClassifier())
    }
}
