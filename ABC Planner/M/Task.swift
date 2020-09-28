//
//  Task.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 04/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name: String?
    @objc dynamic var priority: String?
    @objc dynamic var isDone = false
    var creationDate: Date?
    var parentList = LinkingObjects(fromType: TaskList.self, property: "tasks")
}
