//
//  CustomStyle+ViewModifier.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI

struct FontColor: ViewModifier {
    var textColor: Color
    var font: Font
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
            .font(font)
            .background(backgroundColor == nil ? .clear : backgroundColor)
    }
}

struct Colors: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .background(backgroundColor == nil ? .clear : backgroundColor)
    }
}
