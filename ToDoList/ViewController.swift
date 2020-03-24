//
//  ViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    let toDoArray = ["Finish some work", "Rank up in league", "Keep it up"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }

}

