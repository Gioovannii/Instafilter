//
//  ContentView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var selectTapped = false
    @State private var filterIntensity: CGFloat = 0.5
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
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .scaledToFit()
                    }
                }
                .onTapGesture {
                    // Select an image
                    
                }
                
                HStack {
                    Text("Select the blur amount")
                    Slider(value: $filterIntensity, in: 0.0 ... 1.0)
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
