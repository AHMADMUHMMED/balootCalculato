//
//  LandingViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 21/05/1443 AH.
//

import UIKit
import Firebase
class LandingViewController: UIViewController {
    //    Translation الترجمة

    @IBOutlet weak var changetheLanguageBut: UIButton!
    
    @IBOutlet weak var balootCalculatoLebl: UILabel!
    @IBOutlet weak var registerBut: UIButton!
    @IBOutlet weak var loginBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changetheLanguageBut.setTitle("changethelanguage".localiz, for: .normal)
        balootCalculatoLebl.text = "balootCalculato".localiz
        registerBut.setTitle("register".localiz, for: .normal)
        loginBut.setTitle("login".localiz, for: .normal)
    }
    //    Translation الترجمة

    @IBAction func changeTheLanguageBut(_ sender: Any) {
        
        
        let currentLang = Locale.current.languageCode
        let nweLanguage = currentLang == "en" ? "ar" : "en"
        UserDefaults.standard.setValue([nweLanguage], forKey: "AppleLanguages")
      UserDefaults.standard.setValue([nweLanguage], forKey: "AppleLanguages")
      exit(0)

    }
    


}
extension String {
    var localiz: String {
        return NSLocalizedString(self, tableName: "Localizble", bundle: .main, value: self, comment: self)
    }
}
