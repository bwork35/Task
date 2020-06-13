//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Bryan Workman on 6/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task?
    var dueDateValue: Date? 
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateView()
    }

    

    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        dueDatePicker.resignFirstResponder()
    
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
        let notes = notesTextField.text, !notes.isEmpty else {return}
           
        let dueDate = dueDateValue
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDate)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDate)
        }
        
        
        
        
        
//        if let task = task,
//            let name = nameTextField.text, !name.isEmpty,
//            let notes = notesTextField.text, !notes.isEmpty {
//            let dueDate = dueDateValue
//            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDate)
//        } else {
//            let name = nameTextField.text ?? "task"
//            let notes = notesTextField.text
//            let dueDate = dueDateValue
//            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDate)
//        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateView() {
        guard let task = task else {return}
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dueDateTextField.text = task.due?.stringValue()
        tableView.reloadData()
    }
   
}
