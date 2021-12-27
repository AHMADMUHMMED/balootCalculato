//
//  RegisterViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 21/05/1443 AH.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
let imagePickercontroller = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var userImageView: UIImageView!{
    didSet{
//        لون الخلفية
        userImageView.layer.borderColor = UIColor.systemRed.cgColor
//        عرض الحدود
        userImageView.layer.borderWidth = 3.0
//        زاوية ارتفاع حدود نصف قطرها
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
userImageView.layer.masksToBounds = true
userImageView.isUserInteractionEnabled = true
//        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
//        userImageView.addGestureRecognizer(tabGesture)
    }
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var psswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
//    Translation الترجمة
    @IBOutlet weak var nameLebl: UILabel!
    @IBOutlet weak var emailLebl: UILabel!
    @IBOutlet weak var passwordLebl: UILabel!
    @IBOutlet weak var confirmPasswordLebl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    Translation الترجمة
nameLebl.text = "name".localiz
emailLebl.text = "email".localiz
passwordLebl.text = "password".localiz
confirmPasswordLebl.text = "password".localiz
        
       
    }
    
    @IBAction func byClickingRegister(_ sender: Any) {
        
        if let image = userImageView.image,
            let imageData = image .jpegData(compressionQuality: 0.75),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let password = psswordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            
        }
    }
    
    
    
    
    
    
    
}
