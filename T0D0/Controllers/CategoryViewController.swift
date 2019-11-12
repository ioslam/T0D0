//
//  CategoryViewController.swift
//  T0D0
//
//  Created by Eslam on 10/30/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {
       
    let realm = try! Realm()
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories : Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc =  segue.destination as! TodoViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = categories?[indexPath.row]
            vc.categoryTitle = categories?[indexPath.row].name ?? ""
        }
    }
    // MARK: - Buttons Pressed
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in

            let newCategoryItem = Category()
            newCategoryItem.name = categoryTextField.text!
           // self.categories.append(newCategoryItem)
            self.save(newCategoryItem)
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
    func save(_ category: Category) {
        do {
            try self.realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        self.tableView.reloadData()
    }
    
    func loadData() {
       categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}
