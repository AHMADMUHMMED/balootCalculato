//
//  GameCell.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 02/06/1443 AH.
//

import UIKit
import Firebase

class GameCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var resultUs: UILabel!
    @IBOutlet weak var winner: UILabel!
    @IBOutlet weak var resultThem: UILabel!
    let refrance = Firestore.firestore()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(with post:Game) -> UITableViewCell {
        winner.text = post.winner
        resultThem.text = post.them
        resultUs.text = post.us
        if let currentUserId = Auth.auth().currentUser?.uid {
            if post.user.id != currentUserId {
                userImage.loadImageUsingCache(with: post.user.imageUrl)
            }else {
                refrance.collection("users").document(currentUserId).addSnapshotListener { userSnapshot, error in
                    if let error = error {
                        print("error geting user Snapshot For User Name",error.localizedDescription)
                    }else{
                        if let userSnapshot = userSnapshot {
                            let userData = userSnapshot.data()
                            if let userData = userData {
                                let currentUserData = User(dict: userData)
                                self.userImage.loadImageUsingCache(with: currentUserData.imageUrl)
                            }else {
                                print("User data not found or not the same !!!!!!!!!!!!!")
                            }
                        }
                    }
                }
            }
        }
        return self
    }
    override func prepareForReuse() {
        userImage.image = nil
    }
}
