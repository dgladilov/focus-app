//
//  TaskCell.swift
//  Focus
//
//  Created by Dmitry Gladilov on 24.04.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    
    static let reuseId = "TaskCell"
    
    private var taskNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 17)
        label.numberOfLines = 1
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextItalic, size: 12)
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 15)
        label.textAlignment = .right
        return label
    }()
    
    private var roundsLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 15)
        label.textAlignment = .right
        return label
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.withAlphaComponent(0.1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with task: TaskModel) {
        taskNameLabel.text = task.taskName
        dateLabel.text = formatDate(task.date)
        timeLabel.text = formatTime(task.time)
        roundsLabel.text = task.rounds == 1 ? "1 round" : "\(task.rounds) rounds"
    }
    
    private func formatTime(_ seconds: Int16) -> String {
        let hours = seconds / 3600
        let minutes = seconds % 3600 / 60
        let time = hours == 0 ? seconds < 60 ? "<1m" : String(format: "%02dm", minutes) : String(format: "\(hours)h %02dm", minutes)
        return time
    }
    
    private func formatDate(_ date: Date?) -> String {
        if let date = date{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        } else {
            return "error: no date"
        }
    }
    
    private func setupConstraints() {
        taskNameLabel.translatesAutoresizingMaskIntoConstraints     = false
        dateLabel.translatesAutoresizingMaskIntoConstraints         = false
        timeLabel.translatesAutoresizingMaskIntoConstraints         = false
        roundsLabel.translatesAutoresizingMaskIntoConstraints       = false
        separatorView.translatesAutoresizingMaskIntoConstraints     = false
        
        addSubview(taskNameLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(roundsLabel)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            taskNameLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 25),
            taskNameLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.heightAnchor.constraint(equalToConstant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: taskNameLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            roundsLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            roundsLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            roundsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
 
