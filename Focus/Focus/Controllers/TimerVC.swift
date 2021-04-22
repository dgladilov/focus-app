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
    
    var taskTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.font = UIFont.setFont(name: Fonts.avenirNextItalic, size: 21)
        textField.textColor = Colors.white
        textField.attributedPlaceholder = NSAttributedString(string:"Type your task name", attributes:[NSAttributedString.Key.foregroundColor: Colors.white.withAlphaComponent(0.7)])
        return textField
    }()
    
    var timerView = TimerView()
    
    var startStopButton: StartStopButton = {
        let button = StartStopButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.green
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
        
        taskTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupConstraints()
    }
    
    @objc private func startStopTimerBtnPressed() {
        if !timerIsTicking {
            startStopButton.startTimerButtonAppearance()
            timerView.startWorkTimer()
            timerIsTicking.toggle()
        } else {
            startStopButton.resetTimerButtonAppearance()
            timerView.stopTimer()
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


// MARK: - Setup Constraints
extension TimerVC {
    private func setupConstraints() {
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsButton)
        view.addSubview(statsButton)
        view.addSubview(timerView)
        view.addSubview(taskTextField)
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
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130),
            timerView.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            timerView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: timerView.topAnchor, constant: 100),
            taskTextField.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
            taskTextField.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            taskTextField.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            startStopButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.widthAnchor.constraint(equalToConstant: 180),
            startStopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// MARK: Text Field Delegate
extension TimerVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
