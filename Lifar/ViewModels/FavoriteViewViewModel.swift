//
//  FavoriteViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 16/07/2023.
//

import Foundation
import FirebaseAuth
import Combine


final class FavoriteViewViewModel: ObservableObject {
    
    @Published var favItems: [Cake] = []
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // retreive
    func getFavoriteItems() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionFavorite(retreiveFavs: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] items in
            self?.favItems = items
        }.store(in: &subscriptions)
    }
    
    // delete
    func deleteItem(with name: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionFavorite(delete: name, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            print("DELETION STATE: \(state)")
            self?.getFavoriteItems()
            
        }.store(in: &subscriptions)
    }
    
    // delete all
    func deleteAll() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionFavorite(deleteAllFor: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] _ in
            print("DELETED")
        }.store(in: &subscriptions)

    }
    
    
}
