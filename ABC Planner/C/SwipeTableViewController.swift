//
//  SwipeTableViewController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 25/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // TableView Datasource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    // SwipeCellKit methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Delete action triggered")
            self.deleteItem(at: indexPath)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-action-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }
    
    func deleteItem(at indexPath: IndexPath){
        
    }
}
