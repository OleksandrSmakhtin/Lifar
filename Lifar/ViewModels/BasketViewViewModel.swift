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
    @Published var amountForOrder: Int = 0
    @Published var moneySum: Float = 0.0
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
    
    func countOrder() {
        countMoneySum()
        countAmountOfItems()
    }
    
    
    // count amout of items for order
    private func countAmountOfItems() {
        var result = 0
        for item in items {
            result += item.amountForOrder
        }
        amountForOrder = result
    }
    
    // count money sum
    private func countMoneySum() {
        var result: Float = 0.0
        for item in items {
            guard let price = Float(item.price) else { return }
            result += price
        }
        moneySum = result
    }
    
    
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
