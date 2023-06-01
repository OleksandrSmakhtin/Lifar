//
//  MainViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 01.06.2023.
//

import Foundation
import Combine


final class MainViewViewModel: ObservableObject {
    
    @Published var popularCakes: [Cake] = []
    @Published var newCakes: [Cake] = []
    @Published var allCakes: [Cake] = []
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    
    
    //MARK: - get cakes
    func retrieveCakes(for category: CategoriesTabs) {
        getPopular(for: category)
        
    }
    
    
    
    
    
    //MARK: - Get popular
    private func getPopular(for category: CategoriesTabs) {
        DatabaseManager.shared.collectionPopularCakes(for: category).sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
        } receiveValue: { [weak self] cakes in
            self?.popularCakes = cakes
        }.store(in: &subscriptions)
    }
    
    
}
