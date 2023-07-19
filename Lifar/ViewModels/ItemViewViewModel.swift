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
    
    @Published var isItemInBasket: Bool = false
    @Published var isItemInFavorite: Bool = false
    
    @Published var favorites: [String] = []
    @Published var error: String?
    
    private lazy var itemPrice = Float(item!.price)
    //private var favorites: [String] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    //MARK: - ADD TO FAVORITE
    func addToFavotites() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let title = item?.title else { return }
        guard let item = item else { return }

        if !isItemInFavorite {
            // add
            DatabaseManager.shared.collectionFavorite(add: item, for: userID).sink { [weak self] completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("SAVING TO COLL STATE: \(state)")
            }.store(in: &subscriptions)
        } else {
            // delete
            DatabaseManager.shared.collectionFavorite(delete: title, for: userID).sink { [weak self] completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { isDeleted in
                print("FAV DELETION STATE: \(isDeleted)")
            }.store(in: &subscriptions)
        }
    }
    
    
    //MARK: - CHECK FAVORITES
    func getAndCheckUserFavorites() {
        guard let title = item?.title else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }

        DatabaseManager.shared.collectionFavorite(retreiveFavs: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] favs in
            for fav in favs {
                if fav.title == title {
                    self?.isItemInFavorite = true
                    return
                } else {
                    self?.isItemInFavorite = false
                }
            }
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - ADD TO BASKET
    func addToBasket() {
        guard let item = item else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionBasket(add: item, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { state in
            print("ADDING TO BASKET STATE: \(state)")
        }.store(in: &subscriptions)
    }
    
    //MARK: - CHECK BASKET
    func checkBasket() {
        guard let title = item?.title else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionBasket(retreiveFor: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] basketItems in
            for basketItem in basketItems {
                if basketItem.title == title {
                    self?.isItemInBasket = true
                    print("ITEM IS ALREADY IN BASKET")
                    return
                } else {
                    self?.isItemInBasket = false
                    print("ITEM IS NOT IN BASKET")
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
        item?.amountForOrder = valueToOrder
    }
    
    // minus
    func minusValue() {
        valueToOrder -= 1
        item?.amountForOrder = valueToOrder
    }
    
}
