//
//  AuthViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

final class AuthViewViewModel: ObservableObject {
    
    @Published var email: String?
    @Published var password: String?
    @Published var repeatedPassword: String?
    @Published var isAuthFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    //MARK: - validation forms
    func validateLogInForm() {
        guard let email = email, let password = password else {
            isAuthFormValid = false
            return
        }
        print("email: \(email)\n password:\(password)")
        isAuthFormValid = isValidEmail(email) && password.count >= 6
        print(isAuthFormValid)
    }
    
    
    //MARK: - email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //MARK: - Sign Up User
    func signUpUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.signUpUser(with: email, password: password)
            // handle user output
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
        })
            
            .sink { [weak self] completion in
            // handle errors
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
            // handle firestore
        } receiveValue: { [weak self] user in
            self?.createUserRecord(for: user)
        }.store(in: &subscriptions )
    }
    
    
    //MARK: - Create user record
    private func createUserRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { state in
            print("Adding user record to db: \(state)")
        }.store(in: &subscriptions)
    }
    
    //MARK: - Log In
    private func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.logInUser(with: email, password: password).sink { [weak self] completion in
            // handle errors
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions)
    }
    
    
}
