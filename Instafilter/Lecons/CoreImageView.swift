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
                let currentFilter = CIFilter.sepiaTone() // Sepia
                currentFilter.inputImage = beginImage
                currentFilter.intensity = 1 // Sepia
        
        // MARK: - Pixellate
        
//                let currentFilter = CIFilter.pixellate()
//                currentFilter.inputImage = beginImage
//                currentFilter.scale = 10
        
        // MARK: - Crystallize
        
//                let currentFilter = CIFilter.crystallize()
//                currentFilter.inputImage = beginImage
//                currentFilter.radius = 10
        
        // MARK: - Distortion
        
//        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(150, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(
//            x: inputImage.size.width / 2, y: inputImage.size.height / 2),
//                               forKey: kCIInputCenterKey)
        
        
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
