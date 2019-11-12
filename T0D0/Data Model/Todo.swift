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
    
    let formatter = DateFormatter()
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    
    @objc dynamic var dateCreated: Date? = Date()
    
    // @objc dynamic var dateCreated = DateFormatter.dateFormat(fromTemplate: "Myyyy-MM-dd'T'HH:mm:ssZ", options: 2, locale: Locale(identifier: "en_US"))
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "todos")
    
    
    
}
