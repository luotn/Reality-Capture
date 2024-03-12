//
//  Reality_CaptureApp.swift
//  Reality Capture
//
//  Created by 罗天宁 on 26/04/2022.
//

import SwiftUI

@main
struct Reality_CaptureApp: App {
    
    @StateObject var model = CameraViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}
