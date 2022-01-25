//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Александр Панин on 25.01.2022.
//

import Foundation
import CoreData

class StorageManager {
    static var shared = StorageManager()
    private init() {}
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension StorageManager {
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let  context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data Fetch
    func fetchData() -> [Task] {
        let context = persistentContainer.viewContext
        let fetchRequest = Task.fetchRequest()
        var taskList: [Task] = []
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch {
            print("Faild to fetch data", error)
        }
        return taskList
    }
    
    // MARK: - Core Data Deleting object
    func deleteContext(_ task: Task) {
        let  context = persistentContainer.viewContext
        context.delete(task)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
