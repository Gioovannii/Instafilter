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
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var filterIntensity = 0.5
    @State private var radiusIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var filterName = "Sepia"
    @State private var isImageLoaded = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker.toggle()
                    isImageLoaded.toggle()
                }
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                    }
                    
                    HStack {
                        Text("Radius")
                        Slider(value: $radiusIntensity)
                            .onChange(of: radiusIntensity) { _ in applyProcessing() }
                    }
                }
                .padding(.vertical)
                
                
                HStack {
                    Button(filterName) {
                        showingFilterSheet.toggle()
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        save()
                    }
                    .disabled(isImageLoaded ? false : true)
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Instafilter")
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            
            Button("Crystallize") {
                self.setFilter(CIFilter.crystallize())
                self.filterName = "Crystallize"
            }
            Button("Edges") {
                setFilter(CIFilter.edges())
                filterName = "Edges"
            }
            Button("Gaussian Blur") {
                setFilter(CIFilter.gaussianBlur())
                filterName = "Gaussian Blur"
            }
            Button("Pixellate") {
                setFilter(CIFilter.pixellate())
                filterName = "Pixellate"
            }
            Button("Sepia effect") {
                setFilter(CIFilter.sepiaTone())
                filterName = "Sepia effect"
            }
            Button("Unsharp Mask") {
                setFilter(CIFilter.unsharpMask())
                filterName = "Unsharp Mask"
            }
            Button("Vignette") {
                setFilter(CIFilter.vignette())
                filterName = "Vignette"
            }
        }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oups: \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
        
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(radiusIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func setTitle() {
        filterName = currentFilter.name
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
