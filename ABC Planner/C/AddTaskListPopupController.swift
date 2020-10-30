//
//  AddTaskListPopupController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 29/10/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskListPopupController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addTaskListButton: UIButton!
    @IBOutlet weak var taskListNameTextField: UITextField!
    
    var tableReloadDelegate: tableDataReloadDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 25
        
        addTaskListButton.layer.cornerRadius = 20
        
        taskListNameTextField.layer.borderWidth = 1.0
        taskListNameTextField.layer.cornerRadius = 18
        taskListNameTextField.layer.borderColor = CGColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTaskListButtonPressed(_ sender: UIButton) {
        if let taskName = taskListNameTextField.text {
            let date = Date()
            createNewTaskList(for: date, with: taskName)
        } else {
            print("EMPTY TASK NAME TEXT FIELD")
        }
    }
    
    private func createNewTaskList(for date: Date, with title: String){
        let newTaskList = TaskList()
        newTaskList.dateCreated = date
        newTaskList.taskListName = title
        saveTaskList(taskList: newTaskList)
        
        tableReloadDelegate.reloadTableData()
        dismiss(animated: true, completion: nil)
    }
    
    private func saveTaskList(taskList: TaskList){
        do {
            try realm.write{
                realm.add(taskList)
            }
        } catch {
            print("error while saving taskList do realm: \(error)")
        }
    }
}
