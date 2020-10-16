//
//  PairsTableViewController.swift
//  KobayashiMaru
//
//  Created by Jordan Bryant on 10/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {
    
    let personController = PersonController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        let person = personController.pairsOfPeople[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            personController.deletePersonAtIndex(section: indexPath.section, row: indexPath.row)
    
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if personController.pairsOfPeople.count > 1 {
            return "Pair \(section + 1)"
        } else {
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return personController.pairsOfPeople.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personController.pairsOfPeople[section].count
    }
    
    @IBAction func addPersonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a new person", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a name..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else { return }
            
            self.personController.createNewPerson(name: name)
            self.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func shuffleTapped(_ sender: Any) {
        personController.shufflePairs()
        self.tableView.reloadData()
    }
    
}
