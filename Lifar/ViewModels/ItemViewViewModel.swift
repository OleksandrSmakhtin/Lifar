//
//  ItemViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 06/07/2023.
//

import Foundation
import UIKit
import Combine

final class ItemViewViewModel: ObservableObject {
    
    @Published var item: Cake?
    @Published var valueToOrder = 1
    @Published var isMinusValueActive: Bool = false
    @Published var isPlusValueActive: Bool = true
    private lazy var itemPrice = Float(item!.price)
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
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
