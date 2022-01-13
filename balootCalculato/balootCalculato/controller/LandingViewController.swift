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


    @IBOutlet weak var balootCalculatoLebl: UILabel!
    @IBOutlet weak var registerBut: UIButton!
    @IBOutlet weak var loginBut: UIButton!
    @IBOutlet weak var languageSegmentControl: UISegmentedControl!{
        didSet {
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    languageSegmentControl.selectedSegmentIndex = 0
                case "en":
                    languageSegmentControl.selectedSegmentIndex = 1
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "ar" {
                         languageSegmentControl.selectedSegmentIndex = 0
                     } else if localLang == "fr"{
                         languageSegmentControl.selectedSegmentIndex = 2
                     }else {
                         languageSegmentControl.selectedSegmentIndex = 1
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                 if localLang == "ar" {
                     languageSegmentControl.selectedSegmentIndex = 0
                 } else if localLang == "fr"{
                     languageSegmentControl.selectedSegmentIndex = 2
                 }else {
                     languageSegmentControl.selectedSegmentIndex = 1
                 }
            }
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
//        changetheLanguageBut.setTitle("changethelanguage".localiz, for: .normal)
        balootCalculatoLebl.text = "balootCalculato".localiz
        registerBut.setTitle("register".localiz, for: .normal)
        loginBut.setTitle("login".localiz, for: .normal)
    //    Translation الترجمة

        
//        let currentLang = Locale.current.languageCode
//        let newLanguage = currentLang == "en" ? "ar" : "en"
//        UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
//       exit(0)

  
                
            }
    @IBAction func languageChanged(_ sender: UISegmentedControl) {

        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
                   UserDefaults.standard.set(lang, forKey: "currentLanguage")
                   Bundle.setLanguage(lang)
                   let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                   if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let sceneDelegate = windowScene.delegate as? SceneDelegate {
                       sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                   }
               }
    }
    

    
    


}
extension String {
    var localiz: String {
        return NSLocalizedString(self, tableName: "Localizble", bundle: .main, value: self, comment: self)
    }
}

