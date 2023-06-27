//
//  ProfileViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 27/06/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class ProfileViewViewModel: ObservableObject {
    
    @Published var name: String?
    @Published var error: String?
    @Published var profileMenuItems = MenuItemData.shared.getProfileMenuItems()
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - retreive user
    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: id).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { user in
            self.name = user.name
        }.store(in: &subscriptions)
    }
    
    //MARK: - delete user
    func deleteUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(delete: id).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
            
        } receiveValue: { state in
            
        }.store(in: &subscriptions)
        
        Auth.auth().currentUser?.delete(completion: { [weak self] error in
            if let error = error {
                self?.error = error.localizedDescription
            } else {
                print("SUCCESSFULLY DELETED USER")
            }
        })
    }
    
    
}
