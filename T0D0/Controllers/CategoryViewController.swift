//
//  CategoryViewController.swift
//  T0D0
//
//  Created by Eslam on 10/30/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var delegate: CategoryTitleDelegate?
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryList = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc =  segue.destination as! TodoViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = categoryList[indexPath.row]
            vc.categoryTitle = categoryList[indexPath.row].name!
            
            // Get navigationItem Title By Delegates
            self.delegate?.getCategoryTitle(categoryTitle: categoryList[indexPath.row].name!)
            //self.dismiss(animated: true, completion: nil)
        }
    }
    // MARK: - Buttons Pressed
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCategoryItem = Category(context: self.context)
            newCategoryItem.name = categoryTextField.text!
            self.categoryList.append(newCategoryItem)
            self.saveData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new Category"
            categoryTextField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancel)
       present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Core Data Methods [CRUD]
    func saveData() {
        do {
           try self.context.save()
        } catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadData(with fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryList = try context.fetch(fetchRequest)
        }
        catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
}

