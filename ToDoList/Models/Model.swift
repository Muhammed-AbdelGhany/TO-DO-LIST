//
//  Model.swift
//  ToDoList
//
//  Created by Muhammed on 3/31/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
   @objc dynamic var age : Int = 0
}
