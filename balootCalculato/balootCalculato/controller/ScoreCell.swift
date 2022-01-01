//
//  ScoreCell.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 25/05/1443 AH.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var usLebl: UILabel!

    @IBOutlet weak var themLebl: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code





    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(score:Score) {
        themLebl.text = "\(score.them)"
        usLebl.text = "\(score.us)"
    }
}
