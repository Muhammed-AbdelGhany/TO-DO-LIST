//
//  ViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var toDoArray :Results <Item>?
    
    var selectedCategory : Category? {
        didSet{
        
            loadItems()
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // MARK: - tableView delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        if let item = toDoArray?[indexPath.row]{
            
            
            cell.textLabel?.text = item.title
                   
            if item.done == true {
                       
                       cell.accessoryType = .checkmark
                   }
                   else {
                       cell.accessoryType = .none
                   }
        }
       
        else{
            print("error")
        }
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if let item = toDoArray?[indexPath.row]{
            do{
              
                try realm.write{
                    item.done = !item.done
                }
            }
            catch{
                print("erro at did select ")
            }
            
            
        }
        
        tableView.reloadData()
         tableView.deselectRow(at: indexPath, animated: true)
//        toDoArray[indexPath.row].done = !toDoArray[indexPath.row].done
//        dataSaving(item: <#Item#>)
        
      
    }

    // MARK:  add to do button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var gTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currenctCategory = self.selectedCategory{
                do {
                    try self.realm.write{
                
                let newItem = Item()
                newItem.title = gTextField.text!
                currenctCategory.items.append(newItem)
                        
                    }
                }
                catch{
                    print("Error")
                }
                self.tableView.reloadData()
            
        }
        }
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter to do here"
            gTextField = textField
        }
        
        alert.addAction(action)
            present(alert, animated: true)
    }
    
    // MARK: data saving

    
    
    //MARK: data loading
    
    func loadItems() {
        
        toDoArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

       
}

}

extension ToDoViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        toDoArray = toDoArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {

            searchBar.resignFirstResponder()

            }

        }
    }
}

