//
//  ContentView.swift
//  CatsAndDogs
//
//  Created by Александр on 02.12.22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ImagePickerView(imageClassifier: ImageClassifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
