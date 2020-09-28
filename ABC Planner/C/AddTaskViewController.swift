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

protocol tableDataReloadDelegate {
    func reloadTableData()
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var priorityPicker: UISegmentedControl!
    
    var selectedTaskList: TaskList?
    var tableReloadDelegate: tableDataReloadDelegate!

    let realm = try! Realm()
    let priorityArray = ["A", "B", "C"]
    
    override func viewDidLoad() {
        addTaskButton.layer.cornerRadius = 15
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
}
