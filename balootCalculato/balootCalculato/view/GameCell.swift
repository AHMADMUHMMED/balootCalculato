//
//  GameCell.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 02/06/1443 AH.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var resultUs: UILabel!
    @IBOutlet weak var winner: UILabel!
    @IBOutlet weak var resultThem: UILabel!

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
//        postImageView.loadImageUsingCache(with: Game.imageUrl)
        resultUs.text = post.us
        userImage.loadImageUsingCache(with: post.user.imageUrl)
        return self
    }
    
    override func prepareForReuse() {
        userImage.image = nil
        //postImageView.image = nil
    }
    
}
