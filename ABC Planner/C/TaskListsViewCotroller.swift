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
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        loadTaskLists()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        tableView.rowHeight = 60.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTaskLists()
    }
    
    //MARK: - User interactioin methods
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let currentDate = Date()
        
        // alert instance
        let alert = UIAlertController(title: "Add New Task List", message: "", preferredStyle: .alert)
        
        // task list title text field
        var textField = UITextField()
        
        alert.addTextField { (taskListTitleTextField) in
            taskListTitleTextField.placeholder = "Task List Title"
            textField = taskListTitleTextField
        }
        
        // add task list action
        let addTaskListAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if let taskListTitle = textField.text {
                self.addNewTaskList(for: currentDate, with: taskListTitle)
            }
        }
        
        // cancel action action
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        // adding actions to the alert
        alert.addAction(addTaskListAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addNewTaskList(for date: Date, with title: String) {
        let newTaskList = TaskList()
        newTaskList.dateCreated = date
        newTaskList.taskListName = title
        saveTaskList(taskList: newTaskList)
        loadTaskLists()
    }
    
    //MARK: - DataManipoulation Methods
    func saveTaskList(taskList: TaskList){
        do {
            try realm.write{
                realm.add(taskList)
            }
        } catch {
            print("error while saving taskList do realm: \(error)")
        }
    }
    
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let taskList = taskListsArray?[indexPath.row] {
            cell.textLabel?.text = taskList.taskListName
            let tasksCount = taskList.tasks.count
            let finishedTasksCount = taskList.tasks.filter("isDone == true").count
            cell.detailTextLabel?.text = "\(finishedTasksCount) / \(tasksCount) tasks completed"
            
        } else {
            cell.textLabel?.text = "no dates added yet"
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TasksViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedTaskList = taskListsArray![indexPath.row]
        }
    }
    
    //MARK: - UITableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToTasksSegueId, sender: self)
    }
}
