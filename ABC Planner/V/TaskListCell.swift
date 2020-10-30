//
//  TaskListCell.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 04/10/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit
import SwipeCellKit

class TaskListCell: SwipeTableViewCell {

    @IBOutlet weak var taskListTitle: UILabel!
    @IBOutlet weak var taskListCompletionIndicator: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


