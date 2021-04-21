//
//  PulsatingView.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class PulsatingView: UIView {
    
    private var backView: UIView = {
        let view = UIView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0.2
        return view
    }()
    
    private var topView: UIView = {
        let view = UIView()
        view.alpha = 0.6
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(backView)
        addSubview(topView)
        
        backView.backgroundColor = Colors.green
        topView.backgroundColor = Colors.green
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.layer.cornerRadius = frame.height / 2
        topView.layer.cornerRadius = frame.height / 2
        
        backView.clipsToBounds = true
        topView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor(to color: UIColor) {
        backView.backgroundColor = color
        topView.backgroundColor = color
    }
    
    func startPulsating() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.2
        animation.duration = 1.25
        animation.autoreverses = true
        animation.repeatCount = .infinity
        backView.layer.add(animation, forKey: "pulse")
    }
    
    func stopPulsating() {
        backView.layer.removeAnimation(forKey: "pulse")
    }
    
}
