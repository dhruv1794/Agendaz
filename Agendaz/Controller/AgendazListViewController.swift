//
//  ViewController.swift
//  Agendaz
//
//  Created by Dhruv Mishra on 02/11/18.
//  Copyright © 2018 Dhruv Mishra. All rights reserved.
//

import UIKit

class AgendazListViewController: UITableViewController {

    var myList = [List]()
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.Plist")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       loadData()
        
        
        print(dataFilePath!)
       
}
    
    //MARK - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListItemCell", for: indexPath)
        
        let item = myList[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark :.none
     
        return cell
        
    }
  
     //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myList[indexPath.row].done = !myList[indexPath.row].done
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
   
    }
    
    //MARK - Add new item

    @IBAction func addAgendaPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Agenda", message: "", preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Add Agenda", style: .default) { (actiom) in
            //what happens when user clicks Add Agenda
            let newItem = List()
            newItem.title = textField.text!
            self.myList.append(newItem)
           
         self.saveData()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Agenda"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert,animated: true,completion: nil)
        
    }
    
    // MARK -  Model Manipipulation methods
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(myList)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding array , \(error)")
        }
        tableView.reloadData()
        
        
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                 myList = try decoder.decode([List].self, from: data)
            }catch{
                print("Error loading the data, \(error)")
            }
           
            
        }
    }
    
}


