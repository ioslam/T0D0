//
//  PreviousTodoVC.swift
//  T0D0
//
//  Created by Eslam on 10/29/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit

class PreviousTodoVC: UITableViewController {
     var list: [TodoModel] = []
       
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todo.plist")
     
        
      
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            list.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let thisItem = list[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
            cell.textLabel?.text = thisItem.todoText
            
            // Ternary Expression
            // cell.accessoryType = thisItem.isDone == false ? .none : .checkmark
            
            // Ternary Expression Shorter
               cell.accessoryType = thisItem.isDone ? .checkmark : .none
    //         Equilvant to the code above
            
    /*        if list[indexPath.row].isDone == false {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
    */
            return cell
        }
       
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //      Check True || False
            list[indexPath.row].isDone = !list[indexPath.row].isDone
            saveData()
    //      Equilvant to the code above
            
    /*      if list[indexPath.row].isDone == true {
                list[indexPath.row].isDone = false
            }
            else {
              list[indexPath.row].isDone = true
            }
    */
           tableView.deselectRow(at: indexPath, animated: true)
        }
        
        // MARK: Add Item Button Bar
        @IBAction func addItem(_ sender: UIBarButtonItem) {
                var textField = UITextField()
                let alert = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)

                let action = UIAlertAction(title: "Add", style: .default) { (action) in
    //
                let newTodoItem = TodoModel()
                
                    newTodoItem.todoText = textField.text!
                    self.list.append(newTodoItem)
                    self.saveData()
                
              }
                alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Enter Todo"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        func saveData() {
            let encoder = PropertyListEncoder()
            do{
                let data = try encoder.encode(self.list)
                try data.write(to: self.filePath!)
                
            } catch {
                print("unable to encoder: \(error)")
            }
              self.tableView.reloadData()
        }
        func loadData() {
            let data = try? Data(contentsOf: filePath!)
            let decoder = PropertyListDecoder()
            do {
                list = try decoder.decode([TodoModel].self, from: data!)
            } catch {
                print("\(error)")
            }
        }
    } // End of Class: TodoViewController
