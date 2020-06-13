//
//  TaskController.swift
//  Task
//
//  Created by Bryan Workman on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var fetchedResultsController: NSFetchedResultsController<Task>
    
    init(){
           
           let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
           
           fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true), NSSortDescriptor(key: "due", ascending: true)]
        
           let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
           
           fetchedResultsController = resultsController
           
           
           do{
               try fetchedResultsController.performFetch()
           } catch {
               print(error.localizedDescription)
           }
           
       }
    
    //var tasks: [Task] = []
//    init(){
//        self.tasks = fetchTasks()
//    }
    
    
//    var mockTasks: [Task] {
//        let mop = Task(name: "Mop the floor", notes: "use a mop", due: Date(), isComplete: false)
//        let vacuum = Task(name: "Vacuum the living room", notes: "lots of crumbs", due: Date(), isComplete: false)
//        let groceries = Task(name: "Go grocery shopping", notes: "milk, eggs, and butter", due: Date(), isComplete: true)
//        return [mop, vacuum, groceries]
//    }
    
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes, due: due, isComplete: false)
        saveToPersistenceStore()
       // tasks = fetchTasks()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
        task.name = name
        task.notes = notes
        task.due = due
        task.isComplete = false
        saveToPersistenceStore()
       // tasks = fetchTasks()
    }
    
    func remove(task: Task){
        task.managedObjectContext?.delete(task)
       // tasks = fetchTasks()
    }
    
    func saveToPersistenceStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
        }
    }
    
//    func fetchTasks() -> [Task] {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        return (try? CoreDataStack.context.fetch(request)) ?? []
//    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistenceStore()
    }
    
}
