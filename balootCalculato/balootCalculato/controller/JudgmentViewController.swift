//
//  JudgmentViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 09/06/1443 AH.
//

import UIKit

class JudgmentViewController: UIViewController {

    
    @IBOutlet weak var elvenLebal: UILabel!
    
    @IBOutlet weak var tenLebal: UILabel!
    
    @IBOutlet weak var fourLebal: UILabel!
    
    @IBOutlet weak var threeLebal: UILabel!
    
    @IBOutlet weak var twentyLebal: UILabel!
    
    @IBOutlet weak var Fourteenlebal: UILabel!
    
    
    @IBOutlet weak var zeroSavenLebal: UILabel!
    
    
    @IBOutlet weak var zeroEightLebal: UILabel!
    
    @IBOutlet weak var balootCalculatorBut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elvenLebal.text = "eleven".localiz
        tenLebal.text = "ten".localiz
        fourLebal.text = "four".localiz
        threeLebal.text = "three".localiz
        Fourteenlebal.text = "fourteen".localiz
        twentyLebal.text = "twenty".localiz
        zeroSavenLebal.text = "zero".localiz
        zeroEightLebal.text = "zero".localiz
        balootCalculatorBut.setTitle("balootCalculator".localiz, for: .normal)
        
        
    }
    

    
    
    
}
