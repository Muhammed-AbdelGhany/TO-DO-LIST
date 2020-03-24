//
//  ViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    var toDoArray = ["Finish some work", "Rank up in league", "Keep it up"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
                       tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var gTextField = UITextField()
        let alert = UIAlertController(title: "Add a new to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.toDoArray.append(gTextField.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter to do here"
            gTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    
}

