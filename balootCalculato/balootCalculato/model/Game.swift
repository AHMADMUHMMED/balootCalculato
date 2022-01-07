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
    var winner = " "
    var us = ""
    var them = " "
    var user: User
    var createdAt: Timestamp?
    init(dict:[String:Any],id:String,user:User) {
        if let winner = dict["winner"] as? String,
           let them = dict["them"] as? String,
           let us = dict["us"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.createdAt = createdAt
            self.winner = winner
            self.us = us
            self.them = them
        }
        self.id = id
        self.user = user
    }
}


