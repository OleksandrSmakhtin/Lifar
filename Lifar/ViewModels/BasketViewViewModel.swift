//
//  BasketViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 19/07/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class BasketViewViewModel: ObservableObject {
    
    @Published var items: [Cake] = []
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // retreive
    func retreiveBasket() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionBasket(retreiveFor: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] items in
            self?.items = items
        }.store(in: &subscriptions)
    }
    
    // delete
    func deleteItem(with name: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionBasket(delete: name, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            print("DELETION STATE: \(state)")
            self?.retreiveBasket()
        }.store(in: &subscriptions)
    }
    
    // delete all
    func deleteAll() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionBasket(deleteAllFor: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] _ in
            print("DELETED")
        }.store(in: &subscriptions)
    }
    
}
