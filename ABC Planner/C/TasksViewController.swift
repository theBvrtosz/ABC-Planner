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
        self.title = selectedTaskList?.taskListName
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableData()
    }
    
    //MARK: - User Interaction Methods
    @IBAction func addItemButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.addTaskSegueId, sender: self)
        print("ASDFASFSDA")
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
            cell.taskName.text = item.name
            item.isDone ? cell.setCellAsCompleted(for: item.priority!) : cell.setCellAsIncompleted(for: item.priority!)
        } else {
            cell.taskName.text = "no tasks added"
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
