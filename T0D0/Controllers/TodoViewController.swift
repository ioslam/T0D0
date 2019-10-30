
import UIKit
import CoreData
class TodoViewController: UITableViewController {
  
    var list: [TodoItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("todo.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisItem = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        cell.textLabel?.text = thisItem.title
        
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
                
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
            let newTodoItem = TodoItem(context: context)
                
                newTodoItem.title = textField.text!
                newTodoItem.isDone = false
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
    
    func loadData(with fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()) {
       do {
                 list = try context.fetch(fetchRequest)
                } catch let error as NSError {
                  print("Could not fetch. \(error), \(error.userInfo)")
                  }
        tableView.reloadData()
    }
} // End of Class: TodoViewController

extension TodoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadData(with : fetchRequest)
    }
}
