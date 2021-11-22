//
//  WrappingControllerView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/21.
//

import SwiftUI

struct WrappingControllerView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker.toggle()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct WrappingControllerView_Previews: PreviewProvider {
    static var previews: some View {
        WrappingControllerView()
    }
}
