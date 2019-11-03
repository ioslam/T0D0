//
//  TodoModel.swift
//  T0D0
//
//  Created by Eslam on 10/27/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

// MARK: TodoModel Class /before Using CoreData
// NOTE: This Class has no use now, if it's deleted it won't affect the App at all

class TodoModel: Codable {
    var todoText: String = ""
    var isDone: Bool = false
//    init(_ todoText: String, _ isDone: Bool) {
//        self.todoText = todoText
//        self.isDone = isDone
//    }
}
