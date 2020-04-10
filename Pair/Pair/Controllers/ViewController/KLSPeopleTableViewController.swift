//
//  KLSPeopleTableViewController.swift
//  Pair
//
//  Created by Kelsey Sparkman on 4/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit

class KLSPeopleTableViewController: UITableViewController {
    
    // Mark: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createRandomButton()
    }
    
    // Mark: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add New Person", message: "Add someone new", preferredStyle: .alert)
        
        let nameText = UITextField()
        
        alert.addTextField(configurationHandler: nil)
        
        let cancelButton = UIAlertAction(title: "Um, Nevermind", style: .cancel, handler: nil)
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let name = nameText.text, !name.isEmpty else {return}
            let newPerson = name
            PersonController.shared.create(newPerson: newPerson)
            self.tableView.reloadData()
        }
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        self.present(alert, animated: true)
    }
    
    func createRandomButton() {
        let button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2 - 40, y: self.view.frame.size.height - 150), size: CGSize(width: 80, height: 80)))
        button.setTitle("Switch", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        self.navigationController?.view.addSubview(button)
        button.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
    
    @objc func randomButtonPressed() {
        let count = PersonController.shared.people.count
        if count % 2 == 0 {
            PersonController.shared.random()
            tableView.reloadData()
        } else {
            print("Can't randomize, sorry!")
        }
    }
    
    func indexForPerson(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + (indexPath.row)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PersonController.shared.people.count % 2 == 0 ?
            (PersonController.shared.people.count/2) : (PersonController.shared.people.count/2) + 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group #\(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if PersonController.shared.people.count % 2 == 0 {
            return 2
        } else {
            if section == (tableView.numberOfSections - 1) {
                return 1
            } else {
                return 2
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let person = PersonController.shared.people[indexForPerson(indexPath: indexPath)]
        cell.textLabel?.text = person
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.people[indexForPerson(indexPath: indexPath)]
            PersonController.shared.delete(person: person)
            tableView.reloadData()
        }
    }
}
