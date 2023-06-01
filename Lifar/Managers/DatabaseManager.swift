//
//  DatabaseManager.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 01.06.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine


class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    
    //New/WeddingCakes/Cakes
    //Popular/WeddingCakes/Cakes
    
    //MARK: - Get popular cakes
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
    
    //MARK: - Get new cakes
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
