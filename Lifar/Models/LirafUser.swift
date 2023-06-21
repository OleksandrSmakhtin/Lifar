//
//  LirafUser.swift
//  Lifar
//
//  Created by Oleksandr Smakhtin on 21.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

struct LirafUser: Codable {
    let id: String
    var name: String = ""
    var avatarPath: String = ""
    
    init(from user: User) {
        self.id = user.uid
    }
}
