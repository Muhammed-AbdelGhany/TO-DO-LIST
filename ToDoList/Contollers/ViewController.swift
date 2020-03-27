//
//  ViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    
    var toDoArray = [Items]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if let newArray = defaults.array(forKey: "newToDoArray") as? [String] {
            
          //  toDoArray = newArray}
        
        loadItems()
        
        
    }
    
    // MARK - tableView delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoArray[indexPath.row].title
        
        if toDoArray[indexPath.row].value == true {
            
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        toDoArray[indexPath.row].value = !toDoArray[indexPath.row].value
        dataSaving()
        
      
    }

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var gTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Items()
            newItem.title = gTextField.text!
            
            self.toDoArray.append(newItem)
            
            self.dataSaving()
           // self.defaults.set(self.toDoArray, forKey: "newToDoArray")
            
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter to do here"
            gTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func dataSaving () {
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(toDoArray)
            try data.write(to: dataFilePath!)
            
        }
        catch{
            print("error at saving \(error)")
        }
        tableView.reloadData()
    }
    func loadItems(){
        
        let decoder = PropertyListDecoder()
        do{
            
        let data = try Data(contentsOf: dataFilePath!)
            
            toDoArray = try decoder.decode([Items].self, from: data)
    }
        catch{
            print("error")
        }
    
    
    }
}

