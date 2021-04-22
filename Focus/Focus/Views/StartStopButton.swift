//
//  StartStopButton.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class StartStopButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 24)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startTimerButtonAppearance() {
        UIView.transition(with: self, duration: 0.3, options: .curveEaseInOut) {
            self.backgroundColor = Colors.red
            self.setTitle("Reset", for: .normal)
        }
    }
    
    func resetTimerButtonAppearance() {
        UIView.transition(with: self, duration: 0.3, options: .curveEaseInOut) {
            self.backgroundColor = Colors.green
            self.setTitle("Start", for: .normal)
        }
    }
    
    
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
