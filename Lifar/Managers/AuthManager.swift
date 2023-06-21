//
//  AuthManager.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import FirebaseAuth
import Combine

class AuthManager {
    
    static let shared = AuthManager()
    
    func signUpUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password).map(\.user).eraseToAnyPublisher()
    }
    
    func logInUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password).map(\.user).eraseToAnyPublisher()
    }
    
}
