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
    
    
    
}
