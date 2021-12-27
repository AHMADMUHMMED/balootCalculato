//
//  LoginViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 21/05/1443 AH.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailLabel.text = "email".localiz
        passwordLabel.text = "password".localiz
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
