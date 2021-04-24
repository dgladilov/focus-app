//
//  StatsVC.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class StatsVC: UIViewController {
    
    private var showHours = false
    
    private var tasks = [TaskModel]()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 35)
        label.textColor = Colors.white
        label.text = "Stats"
        label.textAlignment = .center
        return label
    }()
    
    private var graphView = GraphView()
    
    private var switchAxisLabelsButton: SwitchButton = {
        let button = SwitchButton()
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.white.cgColor
        button.addTarget(self, action: #selector(axisLabelsSwitched), for: .touchUpInside)
        button.setTitle("Show hours", for: .normal)
        button.titleLabel?.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 14)
        return button
    }()
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        
        setupConstraints()
        
        CoreDataStack.shared.fetchData { (taskArray) in
            self.tasks = taskArray
        }
        
        graphView.backgroundColor = .clear
        setupTableView()
        setupGraphView()
        
        tableView.reloadData()
    }
    
    @objc private func axisLabelsSwitched() {
        if !showHours {
            graphView.setupStackViewWithHours()
            UIView.transition(with: switchAxisLabelsButton, duration: 0.25, options: .transitionFlipFromBottom) {
                self.switchAxisLabelsButton.setTitle("Show dates", for: .normal)
            }
            showHours.toggle()
        } else {
            setupGraphView()
            UIView.transition(with: switchAxisLabelsButton, duration: 0.25, options: .transitionFlipFromBottom) {
                self.switchAxisLabelsButton.setTitle("Show hours", for: .normal)
            }
            showHours.toggle()
        }
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        tableView.register(TasksTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TasksTableViewHeader.reuseId)
    }
    
    private func setupGraphView() {
        let groupedTasks = graphView.getTasksGroupedByDay(for: tasks)
        guard let dates = graphView.getInfoByDay(info: .dates, from: groupedTasks) as? [Date] else { return }
        graphView.setupStackViewWithDates(dates: dates)
        graphView.setupGraphDisplay(with: tasks)
    }
}


// MARK: - Setup Constraints
extension StatsVC {
    private func setupConstraints() {
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        graphView.translatesAutoresizingMaskIntoConstraints = false
        switchAxisLabelsButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statsLabel)
        view.addSubview(graphView)
        view.addSubview(switchAxisLabelsButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            statsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            graphView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 16),
            graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            graphView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3)
        ])
        
        NSLayoutConstraint.activate([
            switchAxisLabelsButton.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 8),
            switchAxisLabelsButton.trailingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -12),
            switchAxisLabelsButton.heightAnchor.constraint(equalToConstant: 20),
            switchAxisLabelsButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StatsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as? TaskCell else { fatalError("cannot create a reusable cell") }
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = tasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.tasks.remove(at: indexPath.row)
            CoreDataStack.shared.deleteTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        
        return config
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TasksTableViewHeader.reuseId) as? TasksTableViewHeader else { return nil }
        header.tintColor = Colors.purple
        return header
    }
}
