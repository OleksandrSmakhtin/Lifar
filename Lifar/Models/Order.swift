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
    let orderTime: String
    let orderPrice: Float
    let delivery: String
    let contactMethod: String
    var isOrderCompleted: Bool = false
    var orderStatus: String = "New"
    var isExpanded: Bool = false
}
