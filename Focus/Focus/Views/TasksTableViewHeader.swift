//
//  TasksTableViewHeader.swift
//  Focus
//
//  Created by Dmitry Gladilov on 24.04.2021.
//

import UIKit

class TasksTableViewHeader: UITableViewHeaderFooterView {
    
    static let reuseId = "TasksTableViewHeader"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 21)
        label.textColor = Colors.white
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.textAlignment = .right
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 21)
        label.textColor = Colors.white
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
