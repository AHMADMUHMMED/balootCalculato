import UIKit
import Firebase

class UpdateUserDataViewController: UIViewController {
    var selectedGame:Game?
    let imagePickerController = UIImagePickerController()
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.circlerImage()
            userImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var userNameTextField: UITextField!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        getCurrentUserData()
    }
    @IBAction func updateUserPressed(_ sender: Any) {
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let name = userNameTextField.text,
           let currentUserData = Auth.auth().currentUser,
           let currentUserEmail = currentUserData.email {
            let currentUserId = currentUserData.uid
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            let storageRef = Storage.storage().reference(withPath: "users/\(currentUserId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var userData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("users")
                        userData = [
                            "id": currentUserId,
                            "name": name,
                            "email": currentUserEmail,
                            "imageUrl":url.absoluteString,
                        ]
                        ref.document(currentUserId).setData(userData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    func getCurrentUserData() {
        let refrance = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            let currentUserId = currentUser.uid
            refrance.collection("users").document(currentUserId).getDocument { userSnapshot, error in
                if let error = error {
                    print("error geting user Snapshot For User Name",error.localizedDescription)
                }else{
                    if let userSnapshot = userSnapshot {
                        let userData = userSnapshot.data()
                        if let userData = userData {
                            let currentUserData = User(dict: userData)
                            DispatchQueue.main.async {
                                self.userNameTextField.text = currentUserData.name
                                self.userImageView.loadImageUsingCache(with: currentUserData.imageUrl)
                            }
                        }else {
                            print("User data not found or not the same !!!!!!!!!!!!!")
                        }
                    }
                }
            }
        }
    }
}
extension UpdateUserDataViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @objc func selectImage() {
        showAlert()
    }
    func showAlert() {
        let alert = UIAlertController(title: "Chose Profile Picture", message: "Pick From ?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "Photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismessAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismessAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        userImageView.image = selectImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
