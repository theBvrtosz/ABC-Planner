//
//  ViewController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 03/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListsViewCotroller: SwipeTableViewController{
    
    let realm = try! Realm()
    var taskListsArray: Results<TaskList>?

    override func viewDidLoad() {
        //showing navigation controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // reloading data in table
        loadTaskLists()
    }
    
    //MARK: - User interactioin methods
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.showNewTaskListPopupSegueId, sender: self)
    }
    
    
    //MARK: - DataManipoulation Methods
    func loadTaskLists(){
        taskListsArray = realm.objects(TaskList.self).sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    override func deleteItem(at indexPath: IndexPath) {
        if let taskListToDelete = taskListsArray?[indexPath.row] {
            do {
                try realm.write{
                    realm.delete(taskListToDelete)
                }
            } catch {
                print("error while deleting category: \(error)")
            }
        }
    }
    
    //MARK: - UITableViewDataSource  Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListsArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! TaskListCell
        
        if let taskList = taskListsArray?[indexPath.row] {
            
            // setting task list title
            cell.taskListTitle.text = taskList.taskListName
            
            // setting task list completion indicator
            let tasksCount = taskList.tasks.count
            let finishedTasksCount = taskList.tasks.filter("isDone == true").count
            cell.taskListCompletionIndicator.text = "\(finishedTasksCount) / \(tasksCount) tasks completed"
            
        } 
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToTasksSegueId {
            let destinationVC = segue.destination as! TasksViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedTaskList = taskListsArray![indexPath.row]
            }
        } else {
            let destinationVC = segue.destination as! AddTaskListPopupController
            destinationVC.tableReloadDelegate = self
        }
    }
    
    //MARK: - UITableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToTasksSegueId, sender: self)
    }
}

extension TaskListsViewCotroller: tableDataReloadDelegate {
    func reloadTableData() {
        loadTaskLists()
    }
}
