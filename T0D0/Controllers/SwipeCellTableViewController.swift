//
//  SwipeCellTableViewController.swift
//  T0D0
//
//  Created by Eslam on 11/13/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit
import SwipeCellKit
class SwipeCellTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    var cell: UITableViewCell?
    
    override func viewDidLoad() {
           super.viewDidLoad()
       }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.update(at: indexPath)
        // customize the action appearance
        }
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]

}

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //options.transitionStyle = .border
        return options
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
           cell.delegate = self
           return cell
       }
    func update(at indexPath: IndexPath) {
        print("data updated")
    }

}
