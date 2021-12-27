//
//  LandingViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 21/05/1443 AH.
//

import UIKit
import Firebase
class LandingViewController: UIViewController {

    @IBOutlet weak var changeTheLanguageBut: UIBarButtonItem!
    @IBOutlet weak var balootCalculatoLebl: UILabel!
    @IBOutlet weak var registerBut: UIButton!
    @IBOutlet weak var loginBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        balootCalculatoLebl.text = "balootCalculato".localiz
    }
    @IBAction func changeTheLanguageBut(_ sender: Any) {
        
    }
    
    


}
extension String {
    var localiz: String {
        return NSLocalizedString(self, tableName: "Localizble", bundle: .main, value: self, comment: self)
    }
}
