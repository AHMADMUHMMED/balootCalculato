import UIKit
import Firebase
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var erorrInLoginLebal: UILabel!
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginBut: UIButton!
    @IBOutlet weak var orLebl: UILabel!
    @IBOutlet weak var registerBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        //    Translation الترجمة

        emailLabel.text = "email".localiz
        passwordLabel.text = "password".localiz
        orLebl.text = "or".localiz
        loginBut.setTitle("login".localiz, for: .normal)
        registerBut.setTitle("register".localiz, for: .normal)
        
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.becomeFirstResponder()
        }else {

        }
        return true
    }
    
    @IBAction func handleLogin(_ sender: Any) {
    if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error == nil {
                print("Login succesfully")
                }else{
                print(error?.localizedDescription as Any)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator); self.erorrInLoginLebal.text = error?.localizedDescription
                }
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    
}

