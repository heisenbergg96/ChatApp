//
//  LoginVC.swift
//  ChatOfChats
//
//  Created by Vikhyath on 03/01/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var nameFieldWidthConstraint: NSLayoutConstraint?
    var emailHeightConstraint: NSLayoutConstraint?
    var passwordFieldHeightAnchor: NSLayoutConstraint?
    
    // login viewmodel
    let loginViewModel = LoginVM()
    
    let containerView: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        return textField
    }()
    
    let separatorLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let emailField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let separatorLine2: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let passwordField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    let segmentedController: UISegmentedControl = {
        
        let seg = UISegmentedControl(items: ["Login","Regsiter"])
        seg.selectedSegmentIndex = 1
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.tintColor = .white
        seg.backgroundColor = .clear
        seg.addTarget(self, action: #selector(segmentValueDidChange), for: .valueChanged)
        return seg
    }()
    
    let loginRegisterButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 109/255, green: 132/255, blue: 180/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        addSubViews()
        setupAnchors()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func segmentValueDidChange() {
        
        let selectedIndex = segmentedController.selectedSegmentIndex
        loginRegisterButton.setTitle(segmentedController.titleForSegment(at: selectedIndex), for: .normal)
        containerViewHeightConstraint?.constant = selectedIndex == 0 ? 100 : 150
        nameFieldWidthConstraint?.isActive = false
        emailHeightConstraint?.isActive = false
        passwordFieldHeightAnchor?.isActive = false
        nameFieldWidthConstraint = nameField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: selectedIndex == 0 ? 0 : 1/3)
        emailHeightConstraint = emailField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: selectedIndex == 0 ? 1/2 : 1/3)
        passwordFieldHeightAnchor = passwordField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: selectedIndex == 0 ? 1/2 : 1/3)
        nameFieldWidthConstraint?.isActive = true
        emailHeightConstraint?.isActive = true
        passwordFieldHeightAnchor?.isActive = true
        separatorLine1.isHidden = selectedIndex == 0
    }
    
    @objc fileprivate func handleLoginRegister() {
        
        segmentedController.selectedSegmentIndex == 0 ? loginViewModel.handleLogin(email: emailField.text, password: passwordField.text, completion: { (result) in
            
            if let successResult = try? result.get() {
                if successResult {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }) : loginViewModel.handleRegister(email: emailField.text, userName: nameField.text, password: passwordField.text, completion: { (error, isSuccess) in
            
            if error == nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            // show a approriate alert with the error message
            print(error?.localizedDescription as Any)
        })
    }

    fileprivate func addSubViews() {
        
        view.addSubview(containerView)
        containerView.addSubview(nameField)
        containerView.addSubview(separatorLine1)
        containerView.addSubview(emailField)
        containerView.addSubview(separatorLine2)
        containerView.addSubview(passwordField)
        view.addSubview(segmentedController)
        view.addSubview(loginRegisterButton)
    }
    
    fileprivate func setupAnchors() {
        
        // For setting up containerview constraints
        containerView.anchorCenter(to: view)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 150)
        containerViewHeightConstraint?.isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        //For setting up namefield constraints
        var padding: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        nameField.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: padding)
        nameFieldWidthConstraint = nameField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        nameFieldWidthConstraint?.isActive = true
        
        //Setting constraints for separator line.
        var size: CGSize = .init(width: 0, height: 1)
        separatorLine1.anchor(top: nameField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, size: size)
        
        // Setting constraints for emailTextField.
        padding = .init(top: 0, left: 10, bottom: 0, right: 0)
        emailField.anchor(top: nameField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: padding)
        emailHeightConstraint = emailField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        emailHeightConstraint?.isActive = true
        
        //Constraint for separatorline2
        size = .init(width: 0, height: 1)
        separatorLine2.anchor(top: emailField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, size: size)
        
        // constraint for password field
        passwordField.anchor(top: emailField.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        passwordFieldHeightAnchor = passwordField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        passwordFieldHeightAnchor?.isActive = true
        
        // constraint for Segmented Control.
        segmentedController.anchor(top: nil, bottom: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: 0, height: 36))
        
        //setting anchors for login register button
        loginRegisterButton.anchor(top: containerView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
    }
}
