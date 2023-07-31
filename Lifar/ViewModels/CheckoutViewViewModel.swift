//
//  CheckoutViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 31/07/2023.
//

import Foundation
import Combine
import FirebaseAuth

enum ContactMethod: String {
    case byEmail = "Email"
    case byPhone = "Phone"
}

enum DeliveryType: String {
    case pickup = "Pickup"
    case delivery = "Delivery"
}

final class CheckoutViewViewModel: ObservableObject {
    
    @Published var user: LirafUser?
    
    @Published var delivery = DeliveryType.pickup
    @Published var contactMethod = ContactMethod.byEmail
    
    @Published var itemsToOrder: [Cake]?
    @Published var orderPrice: Float?
    
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // retreive order
    func retreiveUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] lirafUser in
            self?.user = lirafUser
        }.store(in: &subscriptions)
    }
    
    // create order
    func createOrder() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        guard let user = user, let itemsToOrder = itemsToOrder, let orderPrice = orderPrice else { return }
                
                
        let order = Order(user: user, items: itemsToOrder, orderTime: Date(), orderPrice: orderPrice, delivery: delivery.rawValue, contactMethod: contactMethod.rawValue)
        
        DatabaseManager.shared.collectionOrders(add: order, for: userID).sink { [weak self] completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] state in
            print("ORDER CREATED: \(state)")
        }.store(in: &subscriptions) 
    }
    
    // configure order
    func configureOrder(toOrder items: [Cake], for price: Float) {
        self.itemsToOrder = items
        self.orderPrice = price
    }
    
    // change delivery
    func changeDeliveryMethod(changeTo type: DeliveryType) {
        delivery = type
    }
    
    // change contact
    func changeContactMethod(changeTo type: ContactMethod) {
        contactMethod = type
    }
}
