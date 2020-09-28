//
//  TasksViewController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 04/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class TasksViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var displayTasks: Results<Task>?
    var selectedTaskList: TaskList?
    
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: K.taskCellNib, bundle: nil), forCellReuseIdentifier: K.cellId)
        reloadTableData()
        tableView.rowHeight = 60.0
        self.title = selectedTaskList?.taskListName
        super.viewDidLoad()
    }
    
    //MARK: - User Interaction Methods
    @IBAction func addItemButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.addTaskSegueId, sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddTaskViewController
        
        if let selectedTaskList = selectedTaskList {
            destinationVC.selectedTaskList = selectedTaskList
            destinationVC.tableReloadDelegate = self
        }
    }
    
    //MARK: - UITableViewDataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayTasks!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! TaskCell
        if let item = displayTasks?[indexPath.row] {
            cell.taskTitle.text = item.name
            cell.taskPriority.text = item.priority
            cell.isDone.image = item.isDone ? UIImage(systemName: "checkmark.rectangle.fill", withConfiguration: .none) : UIImage(systemName: "rectangle", withConfiguration: .none)
            switch item.priority! {
             case "A":
                cell.backgroundColor = UIColor(red: 1.00, green: 0.57, blue: 0.30, alpha: 1.00)
             case "B":
                 cell.backgroundColor = UIColor(red: 1.00, green: 0.74, blue: 0.35, alpha: 1.00)
             case "C":
                 cell.backgroundColor = UIColor(red: 1.00, green: 0.87, blue: 0.35, alpha: 1.00)
             default:
                 cell.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            }
        } else {
            cell.textLabel?.text = "No Tasks Added Yet"
        }
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    override func deleteItem(at indexPath: IndexPath) {
        if let taskToDelete = selectedTaskList?.tasks[indexPath.row] {
            do {
                try realm.write{
                    realm.delete(taskToDelete)
                }
            } catch {
                print("error while deleting category: \(error)")
            }
        }
    }
    
    // TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedTask = displayTasks?[indexPath.row] {
            do {
                try realm.write {
                    selectedTask.isDone = !selectedTask.isDone
                }
            } catch {
                print("Error while updating isDone task property: \(error)")
            }
        }
        reloadTableData()
    }
}

//MARK: - ReloadTableDataDelegate
extension TasksViewController: tableDataReloadDelegate {
    func reloadTableData() {
        displayTasks = selectedTaskList?.tasks.sorted(byKeyPath: "priority", ascending: true)
        tableView.reloadData()
    }
}
