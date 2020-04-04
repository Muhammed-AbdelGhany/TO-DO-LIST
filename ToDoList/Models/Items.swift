//
//  Items.swift
//  ToDoList
//
//  Created by Muhammed on 4/1/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self , property: "items")
}
