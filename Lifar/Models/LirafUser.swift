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
    var address1: String = ""
    var address2: String = ""
    
    init(from user: User, name: String) {
        self.id = user.uid
        self.name = name
    }
}
