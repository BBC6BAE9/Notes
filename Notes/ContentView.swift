//
//  ContentView.swift
//  Notes
//
//  Created by huang on 2023/1/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home().buttonStyle(BorderlessButtonStyle())
            .textFieldStyle(PlainTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
