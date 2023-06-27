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
    
    func getSideMenuItems() -> [MenuItem] {
        let menuItems = [
            MenuItem(title: "Profile", image: "person"),
            MenuItem(title: "Orders", image: "basket"),
            MenuItem(title: "Favorite", image: "heart"),
            MenuItem(title: "Rate app", image: "hand.thumbsup"),
            MenuItem(title: "Share app", image: "square.and.arrow.up"),
            MenuItem(title: "About", image: "questionmark"),
        ]
        return menuItems
    }
    
    func getProfileMenuItems() -> [MenuItem] {
        let menuItems = [
            MenuItem(title: "Change name", image: "textformat.size"),
            MenuItem(title: "Change email", image: "at"),
            MenuItem(title: "Change password", image: "lock"),
            MenuItem(title: "Delivery adress", image: "house"),
            MenuItem(title: "Contact us", image: "phone"),
            MenuItem(title: "Sign Out", image: "rectangle.portrait.and.arrow.forward")
        ]
        
        return menuItems
    }
}
