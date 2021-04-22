//
//  StatsVC.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class StatsVC: UIViewController {
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 35)
        label.textColor = Colors.white
        label.text = "Stats"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        
        setupConstraints()
    }
    
}


// MARK: - Setup Constraints
extension StatsVC {
    private func setupConstraints() {
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statsLabel)
        
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            statsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
