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
    
    func updateEmail(with newEmail: String, for user: User) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            user.updateEmail(to: newEmail) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(true))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updatePassword(with newPassword: String, for user: User) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(true))
                }
            }
        }.eraseToAnyPublisher()
    }
     
    func reauthenticateUser(with password: String, for user: User) -> AnyPublisher<Void, Error> {
        let credential = EmailAuthProvider.credential(withEmail: user.email!, password: password)
        return Future<Void, Error> { promise in
            user.reauthenticate(with: credential) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
