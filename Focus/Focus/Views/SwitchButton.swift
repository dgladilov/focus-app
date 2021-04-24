//
//  SwitchButton.swift
//  Focus
//
//  Created by Dmitry Gladilov on 24.04.2021.
//

import UIKit

class SwitchButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                shrink(down: true, view: self)
            } else {
                shrink(down: false, view: self)
            }
        }
    }
    
    private func shrink(down: Bool, view: UIView) {
        UIView.animate(withDuration: 0.25) {
            if down {
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                view.transform = .identity
            }
        }
    }
    
}
