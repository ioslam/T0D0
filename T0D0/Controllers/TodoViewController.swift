import UIKit
import RealmSwift

class TodoViewController: UITableViewController {
    
    var categoryTitle = ""
    var todos: Results<Todo>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet{
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        navigationItem.title = self.categoryTitle
        if let todoItem = todos?[indexPath.row] {
            cell.textLabel?.text = todoItem.title 
            cell.accessoryType = todoItem.isDone ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items added yet"
        }
        return cell
        // Ternary Expression Shorter
        // cell.accessoryType = todoItem!.isDone ? .checkmark : .none
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  todos?[indexPath.row].isDone = !todos![indexPath.row].isDone
//        context.delete(list[indexPath.row])
//        list.remove(at: indexPath.row)
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Add Item Button Bar
    @IBAction func addItem(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                               
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newTodoItem = Todo()
                            newTodoItem.title = textField.text!
                            currentCategory.todos.append(newTodoItem)
                        self.realm.add(newTodoItem)
                        }
                    } catch {
                        print("errror saving todo item")
                      }
                }
                self.tableView.reloadData()
              
          }
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Todo"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        todos = selectedCategory?.todos.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
} // End of Class: TodoViewController

 // MARK: Search Bar Methods
//extension TodoViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadData(with : fetchRequest, predicate: predicate)
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text == "" {
//            loadData()
//            DispatchQueue.main.async {
//            searchBar.resignFirstResponder()
//            }
//        }
//    }
//}
