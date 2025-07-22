import SwiftUI

// MARK: - BlurView for Investing.swift compatibility
struct BlurView: View {
    let style: BlurStyle
    
    enum BlurStyle {
        case underWindowBackground
        case regular
        case prominent
    }
    
    var body: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .opacity(0.8)
    }
}

// Alternative implementation using UIViewRepresentable for iOS
#if canImport(UIKit)
import UIKit

struct UIBlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
#endif
