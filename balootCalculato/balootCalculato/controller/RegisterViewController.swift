import UIKit
import Firebase
class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var erorrInRegisterLebal: UILabel!
    let imagePickerController = UIImagePickerController()
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
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    @IBOutlet weak var nameRegister: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var psswordTextField: UITextField!
    @IBOutlet weak var passwordResetTextField: UITextField!
    //    Translation الترجمة
    @IBOutlet weak var emailLebl: UILabel!
    @IBOutlet weak var passwordLebl: UILabel!
    @IBOutlet weak var passwordResetLebl: UILabel!
    @IBOutlet weak var registerBut: UIButton!
    @IBOutlet weak var orLebl: UILabel!
    @IBOutlet weak var loginBut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordResetTextField.delegate = self
        psswordTextField.delegate = self
        
        //    Translation الترجمة

        
        emailLebl.text = "email".localiz
        
        passwordLebl.text = "password".localiz
        passwordResetLebl.text = "password reset".localiz
        orLebl.text = "or".localiz
        registerBut.setTitle("register".localiz, for: .normal)
        loginBut.setTitle("login".localiz, for: .normal)
        nameRegister.text = "name".localiz
        
        imagePickerController.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameTextField {
       emailTextField.becomeFirstResponder()
        }else if textField == emailTextField{
            psswordTextField.becomeFirstResponder()
        }else if textField == psswordTextField{
            passwordResetTextField.becomeFirstResponder()
        
        }else{
            
            
        
    }
    return true

}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func byClickingRegister(_ sender: Any) {
        if let image = userImageView.image,
           let imageData = image .jpegData(compressionQuality: 0.75),
           let email = emailTextField.text,
           let name = userNameTextField.text,
           let password = psswordTextField.text,
           let passwordReset = passwordResetTextField.text,
           password == passwordReset {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error{
                self.erorrInRegisterLebal.text = error.localizedDescription
                Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator) }
                if let error = error {
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                            print("Registration Storage Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                print("Registration Storage Download Url Error",error.localizedDescription)
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "id":authResult.user.uid,
                                    "name": name,
                                    "email":email,
                                    "imageUrl":url.absoluteString
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {
                                        print("Registration Database error",error.localizedDescription)
                                    }else {
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
                }
            }
        }
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func selectImage() {
        showAlert()
    }
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
  
}
