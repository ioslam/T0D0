import UIKit
import CoreData

class TodoViewController: UITableViewController {
    var category = CategoryViewController()
    var categoryTitle = "x"
    var list: [TodoItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todo.plist")
    var selectedCategory: Category? {
        didSet{
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //loadData()
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisItem = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        cell.textLabel?.text = thisItem.title
        navigationItem.title = self.categoryTitle

        // Ternary Expression Shorter
           cell.accessoryType = thisItem.isDone ? .checkmark : .none
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        list[indexPath.row].isDone = !list[indexPath.row].isDone
//        context.delete(list[indexPath.row])
//        list.remove(at: indexPath.row)
        saveData()
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Add Item Button Bar
    @IBAction func addItem(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                                
                let newTodoItem = TodoItem(context: self.context)
                
                newTodoItem.title = textField.text!
                newTodoItem.isDone = false
                newTodoItem.parentCategory = self.selectedCategory
                self.list.append(newTodoItem)
                self.saveData()
          }
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Todo"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        
        do{
            try self.context.save()
            
        } catch {
            print("error saving context: \(error)")
        }
          self.tableView.reloadData()
    }
    
    func loadData(with fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest() , predicate: NSPredicate? = nil) {
       
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate {
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            fetchRequest.predicate = categoryPredicate
        }
            do {
                 list = try context.fetch(fetchRequest)
                } catch let error as NSError {
                  print("Could not fetch. \(error), \(error.userInfo)")
                  }
        tableView.reloadData()
    }
} // End of Class: TodoViewController

 // MARK: Search Bar Methods
extension TodoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadData(with : fetchRequest, predicate: predicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadData()
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }
        }
    }
}
