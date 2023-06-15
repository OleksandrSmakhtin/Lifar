//
//  MenuItem.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 15.06.2023.
//

import Foundation

struct MenuItem {
    let title: String
    let image: String
}

class MenuItemData {
    static let shared = MenuItemData()
    
    func getMenuItems() -> [MenuItem] {
        
        let menuItems = [
            MenuItem(title: "Profile", image: "person"),
            MenuItem(title: "Favorite", image: "heart"),
            MenuItem(title: "Rate app", image: "hand.thumbsup"),
            MenuItem(title: "Share app", image: "square.and.arrow.up"),
            MenuItem(title: "About", image: "questionmark"),
        ]
        
        return menuItems
    }
}
