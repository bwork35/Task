//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Bryan Workman on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return TaskController.shared.fetchedResultsController.sections?[section].name == "1" ? "Complete" : "Incomplete"
       }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of rows
          return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.update(withTask: task)
       
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            let taskToSend = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.task = taskToSend
        }
    }
}

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}

        let taskToUpdate = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleIsCompleteFor(task: taskToUpdate)
        sender.updateButton(taskToUpdate.isComplete)
    }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .fade)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }


}

