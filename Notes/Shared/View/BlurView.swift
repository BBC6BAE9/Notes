//
//  BlurView.swift
//  Notes
//
//  Created by huang on 2023/1/29.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var style:UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
    
    
}
