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
    @State private var filterName = "Sepia"
    @State private var filterIntensity: CGFloat = 0.5
    @State private var radiusIntensity: CGFloat = 0.5
    
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double> {
            self.filterIntensity
        } set: {
            self.filterIntensity = $0
            self.applyProcessing()
        }
        
        let radius = Binding<Double>  {
            self.radiusIntensity
        } set: {
            self.radiusIntensity = $0
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
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                    
                }
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                    }
                }
                
                .padding(.vertical)
                
                
                HStack {
                    Button(filterName) {
                        // change filter
                        self.showingFilterSheet.toggle()
                    }
                    .confirmationDialog(Text("Select a filter"), isPresented: $showingFilterSheet) {
                        Button("Crystallize") {
                            self.setFilter(CIFilter.crystallize())
                            self.filterName = "Crystallize"

                        }
                        Button("Edges") {
                            self.setFilter(CIFilter.edges())
                            self.filterName = "Edges"
                        }
                        Button("Gaussian Blur") {
                            self.setFilter(CIFilter.gaussianBlur())
                            self.filterName = "Gaussian Blur"
                        }
                        Button("Pixellate") {
                            self.setFilter(CIFilter.pixellate())
                            self.filterName = "Pixellate"
                        }
                        Button("Sepia effect") {
                            self.setFilter(CIFilter.sepiaTone())
                            self.filterName = "Sepia effect"
                        }
                        Button("Unsharp Mask") {
                            self.setFilter(CIFilter.unsharpMask())
                            self.filterName = "Unsharp Mask"
                        }
                        Button("Vignette") {
                            self.setFilter(CIFilter.vignette())
                            self.filterName = "Vignette"
                        }
                        
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // Save the picture
                        guard let processedImage = self.processedImage else {
                            showingAlert.toggle()
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oups: \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Oups"), message: Text("You must enter an image to save"), dismissButton: .default(Text("Ok")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
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
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radiusIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
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
        self.filterName = self.currentFilter.name
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
