//
//  GraphView.swift
//  Focus
//
//  Created by Dmitry Gladilov on 24.04.2021.
//

import UIKit

enum GetInfo {
    case hours
    case dates
}

class GraphView: UIView {
    
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    
    private let lastWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 14)
        label.text = "Last 7 days"
        return label
    }()

    private let minValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 14)
        label.text = "0"
        return label
    }()
    
    private let maxValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 14)
        label.text = ""
        return label
    }()
    
    private var averageTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.setFont(name: Fonts.avenirNextRegular, size: 14)
        label.text = "Average"
        return label
    }()
    
    private var axisStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        for _ in 0...6 {
            var label = UILabel()
            label.text = "31/12"
            label.font = UIFont.setFont(name: .avenirNextRegular, size: 12)
            label.textColor = Colors.white
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
        return stackView
    }()
    
    private enum Constants {
        static let cornerRadiusSize = CGSize(width: 16.0, height: 16.0)
        static let margin: CGFloat = 24.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.1
        static let circleDiameter: CGFloat = 5.0
    }

    private var startColor: UIColor = Colors.red.withAlphaComponent(0.3)
    private var endColor: UIColor = Colors.orange.withAlphaComponent(0.6)
    private var graphStartColor: UIColor = Colors.red.withAlphaComponent(0.6)
    private var graphEndColor: UIColor = Colors.orange.withAlphaComponent(0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: colorLocations)
        else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        
        // MARK: Calculate points and draw line
        // Calculate the X point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (columnn: Int) -> CGFloat in
            // Gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(columnn) * spacing + margin + 2
        }
        
        // Calculate the Y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoints.max() else { return }
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint
        }
        
        Colors.white.setFill()
        Colors.white.setStroke()
        
        // Set up the points line
        let graphPath = UIBezierPath()
        
        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0),
                                   y: columnYPoint(graphPoints[0])))
        
        // Add points (from graphPoints array)
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.stroke()
        
        
        // MARK: Gradient for graph
        // Create the clipping path for the graph gradient
        
        // Save the state of the context
        context.saveGState()
        
        // Make copy of the path
        guard let clippingPath = graphPath.copy() as? UIBezierPath else { return }
        
        // Add lines to the copied path to comlete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1),
                                         y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0),
                                         y: height))
        clippingPath.close()
        
        // Add the clipping path to the context
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        
        // Graph gradient
        let graphColors = [graphStartColor.cgColor, graphEndColor.cgColor]
        let graphColorSpace = CGColorSpaceCreateDeviceRGB()
        let graphColorLocations: [CGFloat] = [0.0, 1.0]
        guard let graphGradient = CGGradient(colorsSpace: graphColorSpace,
                                             colors: graphColors as CFArray,
                                             locations: graphColorLocations)
        else { return }
        context.drawLinearGradient(graphGradient,
                                   start: graphStartPoint,
                                   end: graphEndPoint,
                                   options: [])
        context.restoreGState()
        
        
        // MARK: Circles at points
        // Draw the circles on top of the graph stroke
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(ovalIn:
                                        CGRect (origin: point,
                                                size: CGSize(width: Constants.circleDiameter,
                                                             height: Constants.circleDiameter)
                                        )
            )
            circle.fill()
        }
        
        
        // MARK: Horizontal graph lines
        let linePath = UIBezierPath()
        
        // Top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 4 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 4 + topBorder))
        
        // Center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 4 * 3 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 4 * 3 + topBorder))
        
        // Bottom line
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        
        let color = Colors.white.withAlphaComponent(Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
    }
    
    private func setupConstraints() {
        lastWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        averageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        axisStackView.translatesAutoresizingMaskIntoConstraints = false
        minValueLabel.translatesAutoresizingMaskIntoConstraints = false
        maxValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lastWeekLabel)
        addSubview(averageTimeLabel)
        addSubview(axisStackView)
        addSubview(minValueLabel)
        addSubview(maxValueLabel)
        
        NSLayoutConstraint.activate([
            lastWeekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            lastWeekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            averageTimeLabel.topAnchor.constraint(equalTo: lastWeekLabel.bottomAnchor, constant: 4),
            averageTimeLabel.leadingAnchor.constraint(equalTo: lastWeekLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            axisStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            axisStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            axisStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            minValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            minValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            maxValueLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 70),
            maxValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    
    
    func getTasksGroupedByDay(for tasks: [TaskModel]) -> [Date: [TaskModel]] {
        let empty: [Date: [TaskModel]] = [:]
        return tasks.reduce(into: empty) { acc, cur in
            let components = Calendar.current.dateComponents([.year, .month, .day], from: cur.date!)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
    }
    
    func getInfoByDay(info: GetInfo, from dict: [Date: [TaskModel]]) -> [Any] {
        
        var newDict = [Date : Int]()
        
        for (key, value) in dict {
            let total = value.map( {$0.time} ).reduce(0, +)
            newDict[key] = Int(total)
        }
        
        let dictSortedByDate = Array(newDict.sorted(by: {$0.key < $1.key }))
        
        var resultArray = [Any]()
        
        for (key, value) in dictSortedByDate {
            switch info {
            case .hours:
                resultArray.append(value)
            case .dates:
                resultArray.append(key)
            }
        }
        
        return resultArray
    }
    
    func setupStackViewWithHours() {
        if graphPoints.isEmpty { graphPoints = [0] }
        for index in 0...6 {
            if let label = axisStackView.arrangedSubviews[index] as? UILabel {
                UIView.transition(with: label, duration: 0.5, options: .transitionFlipFromTop) {
                    label.text = String(self.graphPoints[index] / 3600)
                }
            }
        }
    }
    
    func setupStackViewWithDates(dates: [Date]) {
        let datesArray = dates.suffix(7)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM")
        
        for index in 0..<datesArray.count {
            let date = formatter.string(from: datesArray[index])
            if let label = axisStackView.arrangedSubviews[index] as? UILabel {
                UIView.transition(with: label, duration: 0.5, options: .transitionFlipFromTop) {
                    label.text = date
                }
            }
        }
    }
    
    func setupGraphDisplay(with tasks: [TaskModel]) {
        let statsForEachDay = getTasksGroupedByDay(for: tasks)
        guard let updatedGraphPoints = getInfoByDay(info: .hours, from: statsForEachDay) as? [Int] else { return }
        graphPoints = []
        graphPoints.append(contentsOf: updatedGraphPoints.suffix(7))
        
        if graphPoints.isEmpty { graphPoints = [0] }
        
        graphPoints[graphPoints.count - 1] = Int(updatedGraphPoints.last ?? 0)
        setNeedsDisplay()
        
        if let maxValue = graphPoints.max() {
            if maxValue % 3600 > 0 && maxValue / 3600 < 1 {
                maxValueLabel.text = "<1"
            } else {
                maxValueLabel.text = "\(maxValue / 3600)"
            }
        }
        
        // Fill empty graph points
        if graphPoints.count < 7 {
            for _ in 0..<(7 - updatedGraphPoints.count) {
                graphPoints.append(0)
            }
        }
        
        // Average value for last 7 days
        let average = graphPoints.reduce(0, +) / graphPoints.count
        averageTimeLabel.text = "Average: \(String.secondsToString(seconds: Int16(average)))"
    }
}
