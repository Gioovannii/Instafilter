//
//  ActionSheetView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
            } message: {
                Text("Select a new color")
                    
            }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
    }
}
