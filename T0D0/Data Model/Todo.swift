//
//  Todo.swift
//  T0D0
//
//  Created by Eslam on 11/7/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation
import RealmSwift
class Todo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "todos")
}
