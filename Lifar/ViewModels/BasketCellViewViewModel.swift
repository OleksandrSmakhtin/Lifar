//
//  BasketCellViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 20/07/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class BasketCellViewViewModel: ObservableObject {
    
    @Published var item: Cake?
    @Published var isMinusValueActive: Bool = false
    @Published var isPlusValueActive: Bool = true
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // upddate
    func updateItem() {
        guard let item = item else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.colletionBasket(update: item, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { state in
            print(state)
        }.store(in: &subscriptions)
    }
    
    
    // calculate price
    func calculatePrice(isPlusOperation: Bool) {
        guard let priceForOne = Float(item!.priceForOne) else { return }
        if var price = Float(item!.price) {
            if isPlusOperation {
                price += priceForOne
            } else {
                price -= priceForOne
            }
            item?.price = "\(price)0"
        } else {
            return
        }
    }
    
    // validate
    func validateValue() {
        guard let valueToOrder = item?.amountForOrder else { return }
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
        item?.amountForOrder += 1
    }
    
    // minus
    func minusValue() {
        item?.amountForOrder -= 1
    }
    
}
