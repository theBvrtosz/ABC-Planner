//
//  addTaskViewController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 22/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



class AddTaskViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var priorityPicker: UISegmentedControl!
    @IBOutlet weak var addTaskButton: UIButton!
    
    
    
    
    var selectedTaskList: TaskList?
    var tableReloadDelegate: tableDataReloadDelegate!

    let realm = try! Realm()
    let priorityArray = ["A", "B", "C"]
    
    override func viewDidLoad() {
        backgroundView.layer.cornerRadius = 25
        
        addTaskButton.layer.cornerRadius = 20
        
        taskNameTextField.layer.borderWidth = 1.0
        taskNameTextField.layer.cornerRadius = 18
        taskNameTextField.layer.borderColor = CGColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
        
    }
    
    @IBAction func addTaskButtonPressed(_ sender: UIButton) {
        if let taskName = taskNameTextField.text {
            let selectedPriority = priorityArray[priorityPicker.selectedSegmentIndex]
            
            do {
                try self.realm.write {
                    let newTask = Task()
                    newTask.name = taskName
                    newTask.priority = selectedPriority
                    newTask.creationDate = Date()
                    self.selectedTaskList?.tasks.append(newTask)
                }
            } catch {
                print("error saving context \(error)")
            }
        }
        self.tableReloadDelegate.reloadTableData()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
