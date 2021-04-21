//
//  ViewController.swift
//  Focus
//
//  Created by Dmitry Gladilov on 15.04.2021.
//

import UIKit

class TimerVC: UIViewController {
    
    var timerIsTicking = false
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSettings), for: .touchUpInside)
        return button
    }()
    
    var statsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "burger"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentStats), for: .touchUpInside)
        return button
    }()
    
    var timerView = TimerView()
    
    var startStopButton: StartStopButton = {
        let button = StartStopButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.green.withAlphaComponent(0.8)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startStopTimerBtnPressed), for: .touchUpInside)
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        
        setupConstraints()
    }
    
    @objc private func startStopTimerBtnPressed() {
        if !timerIsTicking {
            startStopButton.startTimerButtonAppearance()
            timerIsTicking.toggle()
        } else {
            startStopButton.resetTimerButtonAppearance()
            timerIsTicking.toggle()
        }
    }
    
    @objc private func presentSettings() {
        let settingsVC = SettingsVC()
        present(settingsVC, animated: true, completion: nil)
    }
    
    @objc private func presentStats() {
        let statsVC = StatsVC()
        present(statsVC, animated: true, completion: nil)
    }

}


// MARK: - Setup Constraints
extension TimerVC {
    
    private func setupConstraints() {
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsButton)
        view.addSubview(statsButton)
        view.addSubview(timerView)
        view.addSubview(startStopButton)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settingsButton.heightAnchor.constraint(equalToConstant: 30),
            settingsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            statsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            statsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statsButton.heightAnchor.constraint(equalToConstant: 30),
            statsButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            timerView.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            timerView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            startStopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.widthAnchor.constraint(equalToConstant: 180),
            startStopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
