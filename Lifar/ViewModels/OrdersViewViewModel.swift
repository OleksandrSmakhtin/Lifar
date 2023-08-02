//
//  OrdersViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 02/08/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class OrdersViewViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // retreive all orders
    func retreiveOrders() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        DatabaseManager.shared.collectionOrders(retreiveFor: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] orders in
            self?.orders = orders
        }.store(in: &subscriptions)
    }
    
    
}
