//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/21.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "giovanni") else { return }
        let beginImage = CIImage(image: inputImage)
        
        // MARK: - Sepia
        
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
        
        // MARK: - Pixellate
        //        let currentFilter = CIFilter.pixellate()
        
        // MARK: - Crystallize
        //        let currentFilter = CIFilter.crystallize()
        
        // MARK: - Distortion
        
        let currentFilter = CIFilter.twirlDistortion()

        currentFilter.inputImage = beginImage
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 150, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
   
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageView()
    }
}
