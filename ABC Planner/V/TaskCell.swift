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
    @IBOutlet weak var taskPriority: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var isDone: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
