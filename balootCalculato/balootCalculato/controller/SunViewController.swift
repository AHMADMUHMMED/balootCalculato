//
//  SunViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 09/06/1443 AH.
//

import UIKit

class SunViewController: UIViewController {

    @IBOutlet weak var elevenInLebal: UILabel!
    
    @IBOutlet weak var tenLebal: UILabel!
    
    @IBOutlet weak var fourLebal: UILabel!
    
    @IBOutlet weak var threeLebal: UILabel!
    
    @IBOutlet weak var twoLebal: UILabel!
    
    @IBOutlet weak var zeroLebal: UILabel!
    
    @IBOutlet weak var zeroInTheSavenLebal: UILabel!
    
    @IBOutlet weak var zeroInTheeightLebal: UILabel!
    
    @IBOutlet weak var balootCalculatorBut: UIButton!
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()

        elevenInLebal.text = "eleven".localiz
        tenLebal.text = "ten".localiz
        fourLebal.text = "four".localiz
        threeLebal.text = "three".localiz
        twoLebal.text = "two".localiz
        zeroLebal.text = "zero".localiz
        zeroInTheSavenLebal.text = "zero".localiz
        zeroInTheeightLebal.text = "zero".localiz
        balootCalculatorBut.setTitle("balootCalculator".localiz, for: .normal)
    }
    


}
