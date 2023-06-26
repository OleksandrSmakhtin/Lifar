//
//  MainViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 01.06.2023.
//

import Foundation
import Combine


final class MainViewViewModel: ObservableObject {
    
    @Published var isSideMenuHidden = true
    @Published var popularCakes: [Cake] = []
    @Published var newCakes: [Cake] = []
    @Published var allCakes: [Cake] = []
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    //MARK: - get user
    func retreiveUser() {
        
    }
    
    //MARK: - get cakes
    func retreiveCakes(for category: CategoriesTabs) {
        getPopular(for: category)
        getNew(for: category)
    }
    
    
    
    //MARK: - Get popular
    private func getPopular(for category: CategoriesTabs) {
        DatabaseManager.shared.collectionPopularCakes(for: category)
//            .handleEvents(receiveOutput: { [weak self] cakes in
//                self?.allCakes = cakes
//            })
            .sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] cakes in
            self?.popularCakes = cakes
            self?.allCakes += cakes
        }.store(in: &subscriptions)
    }
    
    
    //MARK: - Get popular
    private func getNew(for category: CategoriesTabs) {
        DatabaseManager.shared.collectionNewCakes(for: category).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] cakes in
            self?.newCakes = cakes
            
            self?.allCakes += cakes
            
        }.store(in: &subscriptions)
    }
    
    
}
