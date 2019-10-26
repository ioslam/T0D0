
import UIKit

class TodoViewController: UITableViewController {
  
    var list = ["Nasser","Wanda","Ghabbi"]
    let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = self.userData.array(forKey: "Data") as? [String]{
            self.list = items
        }
        
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
        if  self.tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
          let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
          ac.addTextField()

          let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
              let answer = ac.textFields![0]
              self.list.append(answer.text!)
              self.userData.set(self.list, forKey: "Data")
              self.tableView.reloadData()
          }
          ac.addAction(submitAction)
          present(ac, animated: true)
      }
}
