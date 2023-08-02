//
//  DatabaseManager.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 01.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine


class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    
    let usersPath = "Users"
    let favoritesPath = "/favorites"
    let basketPath = "/basket"
    let ordersPath = "Orders"
    
    //MARK: - USER
    // add
    func collectionUsers(add user: User, with name: String) -> AnyPublisher<Bool, Error> {
        let lirafUser = LirafUser(from: user, name: name)
        return db.collection(usersPath).document(lirafUser.id).setData(from: lirafUser).map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // retreive
    func collectionUsers(retreive id: String) -> AnyPublisher<LirafUser, Error> {
        db.collection(usersPath).document(id).getDocument().tryMap { try $0.data(as: LirafUser.self) }.eraseToAnyPublisher()
    }
    
    // delete
    func collectionUsers(delete id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).delete().map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // update
    func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updateFields).map { _ in true }.eraseToAnyPublisher()
    }
    
    
    //MARK: - FAVORITE
    // add
    func collectionFavorite(add item: Cake, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(usersPath)/\(id)\(favoritesPath)").document(item.title).setData(from: item).map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // retreive
    func collectionFavorite(retreiveFavs id: String) -> AnyPublisher<[Cake], Error> {
        db.collection("\(usersPath)/\(id)\(favoritesPath)").getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Cake.self)
                })
            }.eraseToAnyPublisher()
    }
    
    // delete
    func collectionFavorite(delete name: String, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(usersPath)/\(id)\(favoritesPath)").document(name).delete().map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // delete all
    func collectionFavorite(deleteAllFor id: String) -> AnyPublisher<Void, Error> {
        return db.collection("\(usersPath)/\(id)\(favoritesPath)").getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.reference.delete() as Void
                })
            }
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    
    //MARK: - BASKET
    // add to basket
    func collectionBasket(add item: Cake, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(usersPath)/\(id)\(basketPath)").document(item.title).setData(from: item).map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // retreive
    func collectionBasket(retreiveFor id: String) -> AnyPublisher<[Cake], Error> {
        db.collection("\(usersPath)/\(id)\(basketPath)").getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Cake.self)
                })
            }.eraseToAnyPublisher()
    }
    
    // update
    func colletionBasket(update item: Cake, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(usersPath)/\(id)\(basketPath)").document(item.title).setData(from: item).map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // delete
    func collectionBasket(delete name: String, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(usersPath)/\(id)\(basketPath)").document(name).delete().map { _ in
            return true
        }.eraseToAnyPublisher()
    }
    
    // delete all
    func collectionBasket(deleteAllFor id: String) -> AnyPublisher<Void, Error> {
        return db.collection("\(usersPath)/\(id)\(basketPath)").getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.reference.delete() as Void
                })
            }
            .map { _ in }
            .eraseToAnyPublisher()
    }

    
    
    
    
    //MARK: - POPULAR
    func collectionPopularCakes(for category: CategoriesTabs) -> AnyPublisher<[Cake], Error> {
        let path = getPopularPath(for: category)
        return db.collection(path).getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Cake.self)
                })
            }.eraseToAnyPublisher()
    }
    
    //MARK: - NEW
    func collectionNewCakes(for category: CategoriesTabs) -> AnyPublisher<[Cake], Error> {
        let path = getNewPath(for: category)
        return db.collection(path).getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: Cake.self)
                })
            }.eraseToAnyPublisher()
    }
    
    //MARK: - ORDERS
    // add
    func collectionOrders(add item: Order, for id: String) -> AnyPublisher<Bool, Error> {
        db.collection("\(ordersPath)/\(id)/UsersOrders").document(item.orderTime).setData(from: item).map { _ in
            return true
        }.eraseToAnyPublisher()
    }
     
    
    
    //MARK: - Path generator
    private func getPopularPath(for category: CategoriesTabs) -> String {
        switch category {
        case .wedding:
            return "Popular/WeddingCakes/Cakes"
        case .celebration:
            return "celebration"
        case .tarts:
            return "tarts"
        case .cupcakes:
            return "cupcakes"
        case .miniCupcakes:
            return "mini cupcakes"
        case .desserts:
            return "desserts"
        case .macarons:
            return "macarons"
        }
    }
    
    //MARK: - Path generator
    private func getNewPath(for category: CategoriesTabs) -> String {
        switch category {
        case .wedding:
            return "New/WeddingCakes/Cakes"
        case .celebration:
            return "celebration"
        case .tarts:
            return "tarts"
        case .cupcakes:
            return "cupcakes"
        case .miniCupcakes:
            return "mini cupcakes"
        case .desserts:
            return "desserts"
        case .macarons:
            return "macarons"
        }
    }
    
    
}
