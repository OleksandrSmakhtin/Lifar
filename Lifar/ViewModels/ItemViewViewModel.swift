//
//  ItemViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 06/07/2023.
//

import Foundation
import FirebaseAuth
import UIKit
import Combine

final class ItemViewViewModel: ObservableObject {
    
    @Published var item: Cake?
    @Published var valueToOrder = 1
    @Published var isMinusValueActive: Bool = false
    @Published var isPlusValueActive: Bool = true
    @Published var error: String?
    
    private lazy var itemPrice = Float(item!.price)
    private var favorites: [String] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
    func addToFavotites() {
        getUserFavorites()
        
        print("Adding to: \(favorites)")
        print("Addition: \(item)")
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        guard let title = item?.title else { return }
        
        favorites.append(title)
        
        let updatedFields: [String : Any] = [
            "favorite" : favorites
        ]
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] isUpdated in
            print("Is updated? - \(isUpdated)")
        }.store(in: &subscriptions)

        
    }
    
    
    // get favorites
    private func getUserFavorites() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            self?.favorites = user.favorite
        }.store(in: &subscriptions)

    }
    
    
    
    // calculate price
    func calculatePrice(isPlusOperation: Bool) {
        if var price = Float(item!.price) {
            
            if isPlusOperation {
                price += itemPrice!
            } else {
                price -= itemPrice!
            }
            
            
            item?.price = "\(price)0"
        } else {
            return
        }
        
    }
    
    // validate
    func validateValue() {
        if valueToOrder == 1 {
            isMinusValueActive = false
            isPlusValueActive = true
        } else if valueToOrder == 5 {
            isMinusValueActive = true
            isPlusValueActive = false
        } else {
            isPlusValueActive = true
            isMinusValueActive = true
        }
    }
    
    // plus
    func plusValue() {
        valueToOrder += 1
    }
    
    // minus
    func minusValue() {
        valueToOrder -= 1
    }
    
}
