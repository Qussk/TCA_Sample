//
//  View+.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI


extension View {
    func fontColor(_ font: Font, color: Color, background: Color? = nil) -> some View {
        self.modifier(FontColor(textColor: color, font: font, backgroundColor: background))
    }
    
    func colors(_ color: Color, background: Color? = nil) -> some View {
        self.modifier(Colors(foregroundColor: color, backgroundColor: background))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func safeAreaInset(type: SafeAreaInsetType) -> CGFloat {
        let window: UIWindow?
        var top: CGFloat = 0
        var bottom: CGFloat = 0
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.first
            top = window?.safeAreaInsets.top ?? 0
            bottom = window?.safeAreaInsets.bottom  ?? 0
        } else {
            window = UIApplication.shared.keyWindow
            top = window?.safeAreaInsets.top ?? 0
            bottom = window?.safeAreaInsets.bottom ?? 0
        }
        return type == .top ? top : bottom
    }
}

