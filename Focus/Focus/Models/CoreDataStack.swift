//
//  CoreDataStack.swift
//  Focus
//
//  Created by Dmitry Gladilov on 23.04.2021.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Focus")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveData(forTask task: Task) {
        let managedContext = persistentContainer.viewContext
        
        let taskToSave = TaskModel(context: managedContext)
        
        taskToSave.time = Int16(task.time)
        taskToSave.rounds = Int16(task.rounds)
        taskToSave.taskName = task.taskName
        taskToSave.date = task.date
        
        do {
            print("task saved")
            try managedContext.save()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
