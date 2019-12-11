//
//  LoginVM.swift
//  ChatOfChats
//
//  Created by Vikhyath on 10/12/19.
//  Copyright © 2019 Vikhyath. All rights reserved.
//

import Foundation
import Firebase

enum LoginRegisterError: Error {
    
    case emailError
    case paswordError
    case userNameError
    case userNotFound
    case userCannotCreate
    
    var localizedDescription: String {
        
        switch self {
        
        case .emailError:
            return "Proper email"
        case .paswordError:
            return "Valid password not found"
        case .userNameError:
            return "Valid username not found"
        case .userNotFound:
            return "User name not found"
        case .userCannotCreate:
            return "User cannot be created"
        }
    }
}

class LoginVM {
    
    /// Method to handle regiustration of the user into the firebase and storing his credentials in firebase database.
    /// - Parameter email: email of the user
    /// - Parameter userName: username of the user
    /// - Parameter password: user entered password
    /// - Parameter completion: completion block that gives back controller necessary data to update the UI
    func handleRegister(email: String?, userName: String?, password: String?,  completion: @escaping (LoginRegisterError?, Bool) -> Void) {
        
        guard let userName = userName, let email = email, let password = password else {
            completion(.emailError, false)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                completion(.userCannotCreate, false)
                return
            }
            print("Created account successfully!")
            guard let userID = user?.user.uid else {
                
                completion(.userCannotCreate, false)
                return
            }
            
            //Successfully created the account
            let ref = Database.database().reference(fromURL: GeneralConstants.firebaseurl)
            let reference = ref.child("Users").child(userID)
            let values = ["name" : userName, "email" : email]
            
            reference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    completion(.userCannotCreate, false)
                    return
                }
                completion(nil, true)
                print("Saved successfully in database!")
                
            })
        }

    }
    
    func handleLogin(email: String?, password: String?, completion: @escaping (Result<Bool, LoginRegisterError>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(.userNameError))
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                completion(.failure(.userNotFound))
                return
            }
            
            completion(.success(true))
        }
    }
}
