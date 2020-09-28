//
//  TaskList.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 04/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @objc dynamic var dateCreated: Date?
    @objc dynamic var taskListName: String?
    var tasks =  List<Task>()
}

