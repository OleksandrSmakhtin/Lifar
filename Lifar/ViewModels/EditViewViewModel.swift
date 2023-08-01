//
//  EditViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 25/07/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class EditViewViewModel: ObservableObject {
    
    @Published var editType: EditType?
    @Published var user: LirafUser?
    
    @Published var firstField: String?
    @Published var secondField: String?
    
    @Published var isFormValid: Bool = false
    @Published var isChangesSuccessful: Bool?
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - Validation
    func validateForm() {
        guard let type = editType else { return }
        switch type {
        case .name:
            validateName()
        case .email:
            validateEmail()
        case .password:
            validatePassword()
        case .adress:
            validateAddress()
        }
    }
    
    // Name validation
    private func validateName() {
        guard let userName = user?.name, let newUserName = firstField else {
            isFormValid = false
            return
        }
        isFormValid = userName != newUserName && newUserName != "" && newUserName.count >= 3
    }
    
    // Email validation
    private func validateEmail() {
        guard let currentEmail = Auth.auth().currentUser?.email, let newEmail = firstField, let password = secondField  else {
            isFormValid = false
            return
        }
        
        isFormValid = newEmail != currentEmail && isValidEmail(newEmail) && password != "" && password.count > 5
    }
    
    // is email valid
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Password validation
    private func validatePassword() {
        guard let currentPassword = firstField, let newPassword = secondField else {
            isFormValid = false
            return
        }
        isFormValid = currentPassword != newPassword && currentPassword.count > 5 && newPassword.count > 5
    }
    
    // Address validation
    private func validateAddress() {
        guard let adress1 = firstField else {
            isFormValid = false
            return
        }
        
        if secondField != nil {
            isFormValid = adress1.count > 5 && secondField!.count > 5
        } else {
            isFormValid = adress1.count > 5
        }
    }
    
    //MARK: - Change Data
    func changeData() {
        guard let type = editType else { return }
        switch type {
        case .name:
            changeName()
        case .email:
            changeEmail()
        case .password:
            changePassword()
        case .adress:
            changeAddress()
        }
    }
    
    //MARK: - Name
    private func changeName() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let newName = firstField else { return }
        
        let updatedFields: [String : Any] = ["name" : newName]
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.isChangesSuccessful = state
        }.store(in: &subscriptions)

    }
    
    //MARK: - Email
    private func changeEmail() {
        guard let currentUser = Auth.auth().currentUser else { return }
        guard let newEmail = firstField else { return }
        guard let password = secondField else { return }
        
        AuthManager.shared.reauthenticateUser(with: password, for: currentUser).flatMap { _ -> AnyPublisher<Bool, Error> in
            AuthManager.shared.updateEmail(with: newEmail, for: currentUser)
        }
        .sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.isChangesSuccessful = state
        }.store(in: &subscriptions)
        
        
    }
    
    //MARK: - Password
    private func changePassword() {
        guard let currentUser = Auth.auth().currentUser else { return }
        guard let currentPassword = firstField else { return }
        guard let newPassword = secondField else { return }
        
        AuthManager.shared.reauthenticateUser(with: currentPassword, for: currentUser).flatMap { _ -> AnyPublisher<Bool, Error> in
            AuthManager.shared.updatePassword(with: newPassword, for: currentUser)
        }
        .sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.isChangesSuccessful = state
        }.store(in: &subscriptions)
    }
    
    //MARK: - Address
    private func changeAddress() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let adress1 = firstField else { return }
        
        var updatedFields: [String : Any] = [:]
        
        if secondField != nil {
            updatedFields = ["address1" : adress1, "address2" : secondField!]
        } else {
            updatedFields = ["address1" : adress1, "address2" : ""]
        }
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            self?.isChangesSuccessful = state
        }.store(in: &subscriptions)
        
    }
    
    //MARK: - Retreive user
    func retreiveUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions)
    }
    
    
}
