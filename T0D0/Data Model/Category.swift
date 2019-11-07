//
//  Category.swift
//  T0D0
//
//  Created by Eslam on 11/7/19.
//  Copyright © 2019 Eslam. All rights reserved.
//
import RealmSwift
import Foundation
class Category: Object {
    @objc dynamic var name: String = ""
    let todos = List<Todo>()
    
    
}
