//
//  Fonts.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

enum Fonts: String {
    case avenirNextUltraLightItalic = "AvenirNext-UltraLightItalic"
    case avenirNextItalic = "AvenirNext-Italic"
    case avenirNextRegular = "AvenirNext-Regular"
    case avenirNextMedium = "AvenirNext-Medium"
}

extension UIFont {
    
    static func setFont(name: Fonts, size: CGFloat) -> UIFont? {
        return UIFont(name: name.rawValue, size: size)
    }
    
}
