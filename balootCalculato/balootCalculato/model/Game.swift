//
//  Post.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 22/05/1443 AH.
//

import UIKit
import Firebase

struct Game {
    var id = ""
    var winnerId = " "
    var imageUrl = ""
    var result = ""
    var user: User
    var createdAt: Timestamp?
    init(dict:[String:Any],id:String,user:User) {
        if let winnerId = dict["winnerId"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}


