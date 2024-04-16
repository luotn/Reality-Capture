//
//  ContentView.swift
//  Reality Capture
//
//  Created by 罗天宁 on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: CameraViewModel

    var body: some View {
        ZStack {
            // Make the entire background black.
            Color.black.edgesIgnoringSafeArea(.all)
            CameraView(model: model)
        }
        // Force dark mode so the photos pop.
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject private static var model = CameraViewModel()
    static var previews: some View {
        ContentView(model: model)
    }
}
