//
//  Order.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 30/07/2023.
//

import Foundation

struct Order: Codable {
    let user: LirafUser
    let items: [Cake]
    let orederPrice: Float
    let delivery: String
    var isOrderCompleted: Bool = false
    var orederStatus: String
}
