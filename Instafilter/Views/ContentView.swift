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
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double> {
            self.filterIntensity
        } set: {
            self.filterIntensity = $0
            self.applyProcessing()
        }
        
        
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
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                
                HStack {
                    Button("Change Filter") {
                        // change filter
                        self.showingFilterSheet.toggle()
                        
                    }
                    .confirmationDialog(Text("Select a filter"), isPresented: $showingFilterSheet) {
                        Button("Crystallize") { self.setFilter(CIFilter.crystallize()) }
                        Button("Edges") { self.setFilter(CIFilter.edges()) }
                        Button("Gaussian Blur") { self.setFilter(CIFilter.gaussianBlur()) }
                        Button("Pixellate") { self.setFilter(CIFilter.pixellate()) }
                        Button("Sepia effect") { self.setFilter(CIFilter.sepiaTone()) }
                        Button("Unsharp Mask") { self.setFilter(CIFilter.unsharpMask()) }
                        Button("Vignette") { self.setFilter(CIFilter.vignette()) }

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
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
                
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
