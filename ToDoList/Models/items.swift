//
//  items.swift
//  ToDoList
//
//  Created by Muhammed on 3/27/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation

class Items :Encodable , Decodable {
    
    var title : String = ""
    
    var value : Bool = false
}
