//
//  CategoryViewControllerTableViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/30/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewControllerTableViewController: UITableViewController {
    
    var categoryArray :Results<Category>?
    
    let realm = try! Realm()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataloading()
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No items"
        
           
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationCV = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationCV.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         
        var gTexField = UITextField()
        
        let alert = UIAlertController(title: "enter new to do", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = gTexField.text!
            self.dataSaving(category: newCategory)
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "type somthing"
            gTexField = textField
            
        }
        alert.addAction(action)
        present(alert , animated: true)
    }
    
//    MARK: - data saving
    func dataSaving (category : Category) {
       
        do{
            try realm.write{
                realm.add(category)
            }
        }
        catch {
            
            print("error on saving")
        }
        
        tableView.reloadData()
    }
    
//    MARK: Data Loading
    
    
    func dataloading () {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }

}
