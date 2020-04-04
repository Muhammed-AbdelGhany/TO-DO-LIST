//
//  Category.swift
//  ToDoList
//
//  Created by Muhammed on 4/1/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name :String = ""
    
    let items = List<Item>()
    
}
