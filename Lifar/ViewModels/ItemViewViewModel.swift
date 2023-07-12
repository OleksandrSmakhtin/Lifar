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
    @Published var isItemInFavorite: Bool = false
    @Published var favorites: [String] = []
    @Published var error: String?
    
    private lazy var itemPrice = Float(item!.price)
    //private var favorites: [String] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
    func addToFavotites() {
        
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let title = item?.title else { return }

        
        if favorites.contains(title) {
            
            for index in 0...favorites.count - 1 {
                //print(index)
                if favorites[index] == title {
                    favorites.remove(at: index)
                    break
                }
            }
            
        } else {
            favorites.append(title)
        }

        let updatedFields: [String : Any] = [
            "favorite" : favorites
        ]

        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] isUpdated in
            print("Is updated? - \(isUpdated)")
        }.store(in: &subscriptions)

        
    }
    
    
    // get favorites
    func getAndCheckUserFavorites() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] user in
            
            let favorites = user.favorite
            
            self?.favorites = favorites
            
            for fav in favorites {
                
                if fav == self?.item?.title {
                    self?.isItemInFavorite = true
                    return
                } else {
                    self?.isItemInFavorite = false
                }
                
            }
            
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
