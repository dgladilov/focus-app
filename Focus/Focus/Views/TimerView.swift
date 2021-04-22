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
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 50)
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
    
    func startWorkTimer() {
        textTransition(label: statusLabel, text: "Focus", options: .transitionFlipFromBottom)
        colorSwitchAnimation(to: Colors.red)
        pulseView.startPulsating()
    }
    
    func startBreakTimer(withStatus status: String) {
        textTransition(label: statusLabel, text: status, options: .transitionFlipFromBottom)
        colorSwitchAnimation(to: Colors.green)
    }
    
    func stopTimer() {
        textTransition(label: statusLabel, text: "Ready?", options: .transitionFlipFromTop)
        colorSwitchAnimation(to: Colors.green)
        pulseView.stopPulsating()
    }
    
    func updateTimerLabel(with value: Int) {
        timerLabel.text = formatTimeToString(seconds: value)
    }
    
    private func textTransition(label: UILabel, text: String, options: UIView.AnimationOptions) {
        UIView.transition(with: label, duration: 0.5, options: options) {
            label.text = text
        }
    }
    
    private func colorSwitchAnimation(to color: UIColor) {
        UIView.animate(withDuration: 0.5) {
            self.pulseView.changeColor(to: color)
        }
    }
    
    private func formatTimeToString(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        let time = String(format: "%02d:%02d", minutes, seconds)
        return time
    }
    
    
    // MARK: - Setup Constraints
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
            statusLabel.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            pulseView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 60),
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
