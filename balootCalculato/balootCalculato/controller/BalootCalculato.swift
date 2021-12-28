//
//  BalootCalculato.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 23/05/1443 AH.
//

import Foundation
import UIKit
class BalootCalculato : UIViewController{
    //    Translation الترجمة

    @IBOutlet weak var forUsLebl: UILabel!
    
    @IBOutlet weak var forUsLebl3: UILabel!
    @IBOutlet weak var forUsLebl2: UILabel!
    @IBOutlet weak var forThemLebl: UILabel!
    @IBOutlet weak var forThemLebl2: UILabel!
    @IBOutlet weak var forThemLebl3: UILabel!
    @IBOutlet weak var calculateBut: UIButton!
    
    @IBOutlet weak var backBut: UIButton!
    
    @IBOutlet weak var newInGameBut: UIButton!
    
    @IBOutlet weak var nightBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    Translation الترجمة

        forUsLebl.text = "us".localiz
        forThemLebl.text = "them".localiz
        calculateBut.setTitle("Calculate".localiz, for: .normal)
        backBut.setTitle("back".localiz, for: .normal)
        newInGameBut.setTitle("new Game".localiz, for: .normal)
        nightBut.setTitle("night".localiz, for: .normal)
}

}
