//
//  TaskCell.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 27/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import SwipeCellKit

class TaskCell: SwipeTableViewCell {
    
    @IBOutlet weak var priorityFlag: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellAsIncompleted(for priority: String) {
        switch priority {
            case "A":
                priorityFlag.image = UIImage(named: "priority-flag-a")
            case "B":
                priorityFlag.image = UIImage(named: "priority-flag-b")
            case "C":
                priorityFlag.image = UIImage(named: "priority-flag-c")
            default:
                print("error while assigning priority image")
        }
        taskName.textColor = .black
    }
    
    func setCellAsCompleted(for priority: String) {
        switch priority {
            case "A":
                priorityFlag.image = UIImage(named: "priority-flag-a-done")
            case "B":
                priorityFlag.image = UIImage(named: "priority-flag-b-done")
            case "C":
                priorityFlag.image = UIImage(named: "priority-flag-c-done")
            default:
                print("error while assigning priority image")
        }
        taskName.textColor = UIColor(red: 0.77, green: 0.76, blue: 0.76, alpha: 1.00)
    }
}
