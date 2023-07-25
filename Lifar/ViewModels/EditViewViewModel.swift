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
        
    }
    
    // Password validation
    private func validatePassword() {
        
    }
    
    // Address validation
    private func validateAddress() {
        
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
        
    }
    
    //MARK: - Password
    private func changePassword() {
        
    }
    
    //MARK: - Address
    private func changeAddress() {
        
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
