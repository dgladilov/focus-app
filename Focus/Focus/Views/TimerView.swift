//
//  TimerView.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class TimerView: UIView {
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 55)
        label.textColor = Colors.white
        label.text = "Ready?"
        label.textAlignment = .center
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextUltraLightItalic, size: 80)
        label.textColor = Colors.white
        label.textAlignment = .center
        label.text = "00:00"
        return label
    }()
    
    let pulseView = PulsatingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        pulseView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statusLabel)
        addSubview(pulseView)
        pulseView.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            pulseView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 50),
            pulseView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pulseView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pulseView.heightAnchor.constraint(equalTo: pulseView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.centerYAnchor.constraint(equalTo: pulseView.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: pulseView.centerXAnchor)
        ])
    }
    
}
