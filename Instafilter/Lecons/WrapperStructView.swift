//
//  WrapperStructView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import SwiftUI

struct WrapperStructView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        let blur = Binding<CGFloat> {
                self.blurAmount
        }
            set: {
            self.blurAmount = $0
            print("New value is \(self.blurAmount)")
        }

        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct WrapperStructView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperStructView()
    }
}
