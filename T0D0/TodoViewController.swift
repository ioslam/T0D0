
import UIKit

class TodoViewController: UITableViewController {
    let list = ["Nasser","Wanda","Ghabbi"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
