//
//  ContentView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity: CGFloat = 0.5

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                        .cornerRadius(10)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .blur(radius: filterIntensity)
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .scaledToFit()
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                    
                }
                
                HStack {
                    Text("Select the blur amount")
                    Slider(value: $filterIntensity, in: 0.0 ... 1.5)
                }
                .padding(.vertical)
                
                
                HStack {
                    Button("Change Filter") {
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // Save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
                    
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
