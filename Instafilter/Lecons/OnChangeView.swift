//
//  OnChangeView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/12/21.
//

import SwiftUI

struct OnChangeView: View {
        @State private var blurAmount = 0.0
         
        var body: some View {
            VStack {
                Text("Hello, World!")
                    .blur(radius: blurAmount)
                    .padding(.bottom, 20)
                
                Slider(value: $blurAmount, in: 0...20)
                    .onChange(of: blurAmount) { newValue in
                        print(newValue)
                    }
                
                Button("Random Blur") {
                    blurAmount = Double.random(in: 0...20)
                }
            }
        }
    }

    struct OnChangeView_Previews: PreviewProvider {
        static var previews: some View {
            OnChangeView()
        }
    }

