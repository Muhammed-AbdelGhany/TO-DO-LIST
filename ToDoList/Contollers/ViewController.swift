//
//  ViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDoArray = [Item]()
    
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
        return toDoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoArray[indexPath.row].title
        
        if toDoArray[indexPath.row].done == true {
            
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        toDoArray[indexPath.row].done = !toDoArray[indexPath.row].done
        dataSaving()
        
      
    }

    // MARK:  add to do button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var gTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            
            newItem.title = gTextField.text!
            newItem.done = false
            newItem.parent = self.selectedCategory
            
            self.toDoArray.append(newItem)
            
            self.dataSaving()
           
            
        }
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter to do here"
            gTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: data saving
    
    func dataSaving () {
    
        do{
            try context.save()
            
        }
        catch{
            print("error at saving \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: data loading
    
    func loadItems(request : NSFetchRequest<Item> = Item.fetchRequest() , predicet :NSPredicate? = nil){
        
        let categoryPredicate = NSPredicate(format: "parent.name MATCHES %@" , selectedCategory!.name!)
        
        if let additionalPredicate = predicet {
            
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate , additionalPredicate])
            request.predicate = compoundPredicate
        }
        else {
            request.predicate = categoryPredicate
        }

    do{
        
   try toDoArray = context.fetch(request)
    
    }
    catch{
        
        print("the is error in load items \(error)")
    }
        tableView.reloadData()
    
    }
}

extension ToDoViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(request: request ,predicet: predicate )
        
        
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

