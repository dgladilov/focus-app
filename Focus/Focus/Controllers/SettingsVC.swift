//
//  SettingsVC.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class SettingsVC: UIViewController {
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 35)
        label.textColor = Colors.white
        label.text = "Settings"
        label.textAlignment = .center
        return label
    }()
    
    private let workLabel: UILabel = {
        let label = UILabel()
        label.text = "Work"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        return label
    }()
    
    private let shortBreakLabel: UILabel = {
        let label = UILabel()
        label.text = "Shork break"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        return label
    }()
    
    private let longBreakLabel: UILabel = {
        let label = UILabel()
        label.text = "Long break"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        return label
    }()
    
    private var workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "25 min"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        label.textAlignment = .right
        return label
    }()
    
    private var shortBreakTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "5 min"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        label.textAlignment = .right
        return label
    }()
    
    private var longBreakTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "20 min"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 19)
        label.textColor = Colors.white
        label.textAlignment = .right
        return label
    }()
    
    var workTimeSlider: TimeSlider = {
        let slider = TimeSlider()
        slider.maximumTrackTintColor = Colors.white
        slider.minimumTrackTintColor = Colors.red
        slider.thumbTintColor = Colors.red
        slider.maximumValue = 59
        slider.minimumValue = 1
        slider.value = 25
        slider.addTarget(self, action: #selector(workTimeValueChanged), for: .valueChanged)
        return slider
    }()
    
    var shortBreakTimeSlider: TimeSlider = {
        let slider = TimeSlider()
        slider.maximumTrackTintColor = Colors.white
        slider.minimumTrackTintColor = Colors.green
        slider.thumbTintColor = Colors.green
        slider.maximumValue = 30
        slider.minimumValue = 1
        slider.value = 5
        slider.addTarget(self, action: #selector(shortBreakTimeValueChanged), for: .valueChanged)
        return slider
    }()
    
    var longBreakTimeSlider: TimeSlider = {
        let slider = TimeSlider()
        slider.maximumTrackTintColor = Colors.white
        slider.minimumTrackTintColor = Colors.green
        slider.thumbTintColor = Colors.green
        slider.maximumValue = 59
        slider.minimumValue = 1
        slider.value = 20
        slider.addTarget(self, action: #selector(longBreakTimeValueChanged), for: .valueChanged)
        return slider
    }()
    
    var saveButton: StartStopButton = {
        let button = StartStopButton()
        button.backgroundColor = Colors.orange
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        
        setupConstraints()
    }
    
    @objc private func workTimeValueChanged() {
        print(workTimeSlider.value)
    }
    
    @objc private func shortBreakTimeValueChanged() {
        print(shortBreakTimeSlider.value)
    }
    
    @objc private func longBreakTimeValueChanged() {
        print(longBreakTimeSlider.value)
    }
    
    @objc private func saveSettings() {
        print("data saved")
        dismiss(animated: true)
    }
    
}


// MARK: - Setup Constraints
extension SettingsVC {
    private func setupConstraints() {
        settingsLabel.translatesAutoresizingMaskIntoConstraints         = false
        workLabel.translatesAutoresizingMaskIntoConstraints             = false
        shortBreakLabel.translatesAutoresizingMaskIntoConstraints       = false
        longBreakLabel.translatesAutoresizingMaskIntoConstraints        = false
        
        workTimeLabel.translatesAutoresizingMaskIntoConstraints         = false
        shortBreakTimeLabel.translatesAutoresizingMaskIntoConstraints   = false
        longBreakTimeLabel.translatesAutoresizingMaskIntoConstraints    = false
        
        workTimeSlider.translatesAutoresizingMaskIntoConstraints        = false
        shortBreakTimeSlider.translatesAutoresizingMaskIntoConstraints  = false
        longBreakTimeSlider.translatesAutoresizingMaskIntoConstraints   = false
        
        saveButton.translatesAutoresizingMaskIntoConstraints            = false
        
        view.addSubview(settingsLabel)
        view.addSubview(workLabel)
        view.addSubview(shortBreakLabel)
        view.addSubview(longBreakLabel)
        
        view.addSubview(workTimeLabel)
        view.addSubview(shortBreakTimeLabel)
        view.addSubview(longBreakTimeLabel)
        
        view.addSubview(workTimeSlider)
        view.addSubview(shortBreakTimeSlider)
        view.addSubview(longBreakTimeSlider)
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            settingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            workTimeSlider.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 90),
            workTimeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            workTimeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            shortBreakTimeSlider.topAnchor.constraint(equalTo: workTimeSlider.bottomAnchor, constant: 90),
            shortBreakTimeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            shortBreakTimeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            longBreakTimeSlider.topAnchor.constraint(equalTo: shortBreakTimeSlider.bottomAnchor, constant: 90),
            longBreakTimeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            longBreakTimeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            workLabel.bottomAnchor.constraint(equalTo: workTimeSlider.topAnchor, constant: -16),
            workLabel.leadingAnchor.constraint(equalTo: workTimeSlider.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shortBreakLabel.bottomAnchor.constraint(equalTo: shortBreakTimeSlider.topAnchor, constant: -16),
            shortBreakLabel.leadingAnchor.constraint(equalTo: shortBreakTimeSlider.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            longBreakLabel.bottomAnchor.constraint(equalTo: longBreakTimeSlider.topAnchor, constant: -16),
            longBreakLabel.leadingAnchor.constraint(equalTo: longBreakTimeSlider.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            workTimeLabel.bottomAnchor.constraint(equalTo: workTimeSlider.topAnchor, constant: -16),
            workTimeLabel.trailingAnchor.constraint(equalTo: workTimeSlider.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            shortBreakTimeLabel.bottomAnchor.constraint(equalTo: shortBreakTimeSlider.topAnchor, constant: -16),
            shortBreakTimeLabel.trailingAnchor.constraint(equalTo: shortBreakTimeSlider.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            longBreakTimeLabel.bottomAnchor.constraint(equalTo: longBreakTimeSlider.topAnchor, constant: -16),
            longBreakTimeLabel.trailingAnchor.constraint(equalTo: longBreakTimeSlider.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 180),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
