//
//  ActionSheetView.swift
//  Instafilter
//
//  Created by Giovanni Gaffé on 2021/11/20.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .cornerRadius(20)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .confirmationDialog(Text("Change background"), isPresented: $showingActionSheet) {
                Button("Red") { self.backgroundColor = .red }
                Button("Green") { self.backgroundColor = .green }
                Button("Blue") { self.backgroundColor = .blue }
                
            }
    }
}

struct ActionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetView()
    }
}
