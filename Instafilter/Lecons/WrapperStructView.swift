//
//  WrapperStructView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import SwiftUI

struct WrapperStructView: View {
    @State private var blurAmount = 0.0
     
    var body: some View {
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
               
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

struct WrapperStructView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperStructView()
    }
}
