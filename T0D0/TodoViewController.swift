
import UIKit

class TodoViewController: UITableViewController {
  
    var list: [TodoModel] = []
    var myTodos = TodoModel()
    let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let items = self.userData.array(forKey: "Data") as? [String]{
//            self.list = items
//      }
       self.myTodos.todoText = "Play"
        self.myTodos.isDone = true
        //let new = TodoModel()
        //new.todoText = "Jaban"
        self.list.append(myTodos)
    }
  
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
        
//      Equilvant to the code above
        
/*      if list[indexPath.row].isDone == true {
            list[indexPath.row].isDone = false
        }
        else {
          list[indexPath.row].isDone = true
        }
*/
        self.tableView.reloadData()
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Add Item Button Bar
    @IBAction func addItem(_ sender: UIBarButtonItem) {
          let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
          ac.addTextField()

          let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
              let answer = ac.textFields![0]
            self.list[0].todoText.append(answer.text!)
              self.userData.set(self.list, forKey: "Data")
              self.tableView.reloadData()
          }
          ac.addAction(submitAction)
          present(ac, animated: true)
      }
}
