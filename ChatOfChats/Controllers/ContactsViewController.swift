//
//  ContactsViewController.swift
//  ChatOfChats
//
//  Created by Vikhyath on 15/01/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UITableViewController {
    
    var users: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        fetchUser()
    }
    
    fileprivate func fetchUser() {
        
        Database.database().reference().child("Users").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    @objc func handleCancel() { 
        
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") else { return UITableViewCell() }
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
}
