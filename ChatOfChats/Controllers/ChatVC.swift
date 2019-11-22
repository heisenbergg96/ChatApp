//
//  ChatVC.swift
//  ChatOfChats
//
//  Created by Vikhyath on 03/01/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutAction))
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(handleNewMsg)), animated: false)
        isUserLoggedIn()
    }
    
    @objc fileprivate func handleNewMsg() {
        
        let contacts = ContactsViewController()
        let navController = UINavigationController(rootViewController: contacts)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func logoutAction() {
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print(signOutError)
        }
        
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true)
    }
    
    fileprivate func isUserLoggedIn() {
        //when user not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(logoutAction), with: nil, afterDelay: 0)
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self?.navigationItem.title = dictionary["name"] as? String
                }
            })
        }
    }

}

