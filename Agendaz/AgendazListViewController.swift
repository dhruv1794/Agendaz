//
//  ViewController.swift
//  Agendaz
//
//  Created by Dhruv Mishra on 02/11/18.
//  Copyright © 2018 Dhruv Mishra. All rights reserved.
//

import UIKit

class AgendazListViewController: UITableViewController {

    var myList = ["peevi you are","my life !","I want you till my death bed","and more","dont hate me for wanting so much!"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        if let items = defaults.array(forKey: "myListArray") as? [String] {
            myList = items
        }
       
        
    }
    
    //MARK - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListItemCell", for: indexPath)
        cell.textLabel?.text = myList[indexPath.row]
      
        return cell
        
    }
  
     //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new item

    @IBAction func addAgendaPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Agenda", message: "", preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Add Agenda", style: .default) { (actiom) in
            //what happens when user clicks Add Agenda
            self.myList.append(textField.text!)
            self.defaults.set(self.myList, forKey: "myListArray")
            self.tableView.reloadData()
            print("Succes")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Agenda"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
}

