//
//  StatsVC.swift
//  Focus
//
//  Created by Dmitry Gladilov on 21.04.2021.
//

import UIKit

class StatsVC: UIViewController {
    
    private var tasks = [TaskModel]()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 35)
        label.textColor = Colors.white
        label.text = "Stats"
        label.textAlignment = .center
        return label
    }()
    
    private var graphView: GraphView = {
        let view = GraphView()
        
        view.backgroundColor = .white
        return view
    }()
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.purple
        
        setupConstraints()
        
        CoreDataStack.shared.fetchData { (taskArray) in
            self.tasks = taskArray
        }
        
        setupTableView()
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
    }
    
}


// MARK: - Setup Constraints
extension StatsVC {
    private func setupConstraints() {
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        graphView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statsLabel)
        view.addSubview(graphView)
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
}
