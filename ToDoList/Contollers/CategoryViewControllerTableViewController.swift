//
//  CategoryViewControllerTableViewController.swift
//  ToDoList
//
//  Created by Muhammed on 3/30/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataloading()
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
           
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationCV = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
               destinationCV.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         
        var gTexField = UITextField()
        
        let alert = UIAlertController(title: "enter new to do", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = gTexField.text!
            self.categoryArray.append(newCategory)
            
            self.dataSaving()
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "type somthing"
            gTexField = textField
            
        }
        alert.addAction(action)
        present(alert , animated: true)
    }
    
    func dataSaving () {
       
        do{
            try context.save()
        }
        catch {
            
            print("error on saving")
        }
        tableView.reloadData()
    }
    
    func dataloading () {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
        try categoryArray = context.fetch(request)
        }
        catch{
            print("error on loading")
            
        }
        tableView.reloadData()
    }
    
}
