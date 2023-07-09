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
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateValue() {
        if valueToOrder > 1 {
            isMinusValueActive = true
            isPlusValueActive = true
        } else {
            isMinusValueActive = false
        }
        
        if valueToOrder < 5 {
            isMinusValueActive = true
            isPlusValueActive = true
        } else {
            isPlusValueActive = true
        }
    }
    
    func plusValue() {
        valueToOrder += 1
    }
    
    func minusValue() {
        valueToOrder -= 1
    }
    
}
