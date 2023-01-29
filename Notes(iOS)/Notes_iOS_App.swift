//
//  Notes_iOS_App.swift
//  Notes(iOS)
//
//  Created by huang on 2023/1/29.
//

import SwiftUI

@main
struct Notes_iOS_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
    
}

