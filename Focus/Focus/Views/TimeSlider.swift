//
//  TimeSlider.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class TimeSlider: UISlider {
    
    var trackLineHeight: CGFloat = 3
    
    override func trackRect(forBounds bound: CGRect) -> CGRect {
        return CGRect(origin: bound.origin, size: CGSize(width: bound.width, height: trackLineHeight))
    }
    
}
