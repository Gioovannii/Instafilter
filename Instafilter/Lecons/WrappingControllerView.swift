//
//  WrappingControllerView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/21.
//

import SwiftUI

struct WrappingControllerView: View {
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker.toggle()
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }

                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
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
