//
//  EditViewViewModel.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 25/07/2023.
//

import Foundation
import Combine
import FirebaseAuth


final class EditViewViewModel: ObservableObject {
    
    @Published var editType: EditType?
    
    @Published var error: String?
    
    private var subscription: Set<AnyCancellable> = []
    
    
    //MARK: - Name
    func changeName() {
        
    }
    
    //MARK: - Email
    func changeEmail() {
        
    }
    
    //MARK: - Password
    func changePassword() {
        
    }
    
    //MARK: - Address
    func changeAddress() {
        
    }
    
    
}
