//
//  TaskModel+CoreDataProperties.swift
//  Focus
//
//  Created by Dmitry Gladilov on 23.04.2021.
//
//

import Foundation
import CoreData


extension TaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var rounds: Int16
    @NSManaged public var time: Int16
    @NSManaged public var date: Date?

}

extension TaskModel : Identifiable {

}
