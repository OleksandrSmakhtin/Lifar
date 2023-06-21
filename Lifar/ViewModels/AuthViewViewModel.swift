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
        
        isAuthFormValid = isValidEmail(email) && password.count >= 6
    }
    
    
    //MARK: - email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
