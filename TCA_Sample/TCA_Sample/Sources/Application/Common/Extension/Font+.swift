//
//  Font+.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI


extension Font {
    static var h1: Font {
        return bold(size: 20)
    }
    
    static var h2: Font {
        return bold(size: 18)
    }
    
    static var h3: Font {
        return regular(size: 18)
    }
    
    static var h4: Font {
        return bold(size: 16)
    }
    
    static var h5: Font {
        return regular(size: 16)
    }
    
    static var h6: Font {
        return bold(size: 14)
    }
    
    static var h7: Font {
        return medium(size: 14)
    }
    
    
    static func bold(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Bold", size: size)
    }
    
    static func medium(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Medium", size: size)
    }
    
    static func regular(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Regular", size: size)
    }
    
    static func light(size: CGFloat) -> Font {
        return Font.custom("SpoqaHanSansNeo-Light", size: size)
    }
}
