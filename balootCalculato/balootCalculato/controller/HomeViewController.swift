import UIKit
import Firebase
class HomeViewController: UIViewController {
    
    
    
    
    var games = [Game]()
    var selectedGame:Game?
    var selectedGameImage:UIImage?
    
    @IBOutlet weak var gamesTableView: UITableView! {
        didSet {
            gamesTableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
            gamesTableView.delegate = self
            gamesTableView.dataSource = self
            gamesTableView.register(UINib(nibName: "GameCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        }
    }
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderWidth = 3.0
            //        زاوية ارتفاع حدود نصف قطرها
            userImageView.layer.cornerRadius = userImageView.bounds.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gotoUpdateUser))
            userImageView.addGestureRecognizer(tapGesture)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserData()
        getPosts()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "exit".localiz, style: .plain, target: nil, action: nil)
    }
    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("Game").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let postData = diff.document.data()
                    switch diff.type {
                    case .added :
                        if let userId = postData["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let post = Game(dict:postData,id:diff.document.documentID,user:user)
                                    self.gamesTableView.beginUpdates()
                                    if snapshot.documentChanges.count != 1 {
                                        self.games.append(post)
                                        self.gamesTableView.insertRows(at: [IndexPath(row:self.games.count - 1,section: 0)],with: .automatic)
                                    }else {
                                        self.games.insert(post,at:0)
                                        self.gamesTableView.insertRows(at: [IndexPath(row: 0,section: 0)],with: .automatic)
                                    }
                                    self.gamesTableView.endUpdates()
                                }
                            }
                        }
                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.games.first(where: {$0.id == postId}),
                           let updateIndex = self.games.firstIndex(where: {$0.id == postId}){
                            let newPost = Game(dict:postData, id: postId, user: currentPost.user)
                            self.games[updateIndex] = newPost
                            self.gamesTableView.beginUpdates()
                            self.gamesTableView.deleteRows(at: [IndexPath(row: updateIndex,section: 0)], with: .left)
                            self.gamesTableView.insertRows(at: [IndexPath(row: updateIndex,section: 0)],with: .left)
                            self.gamesTableView.endUpdates()
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.games.firstIndex(where: {$0.id == postId}){
                            self.games.remove(at: deleteIndex)
                            self.gamesTableView.beginUpdates()
                            self.gamesTableView.deleteRows(at: [IndexPath(row: deleteIndex,section: 0)], with: .automatic)
                            self.gamesTableView.endUpdates()
                        }
                    }
                }
            }
        }
    }
    @IBAction func handleLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }
    }
    func getCurrentUserData() {
        let refrance = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            let currentUserId = currentUser.uid
            refrance.collection("users").document(currentUserId).addSnapshotListener { userSnapshot, error in
                if let error = error {
                    print("error geting user Snapshot For User Name",error.localizedDescription)
                }else{
                    if let userSnapshot = userSnapshot {
                        let userData = userSnapshot.data()
                        if let userData = userData {
                            let currentUserData = User(dict: userData)
                            DispatchQueue.main.async {
                                self.userImageView.loadImageUsingCache(with: currentUserData.imageUrl)
                                self.currentUserName.text = currentUserData.name
                            }
                        }else {
                            print("User data not found or not the same !!!!!!!!!!!!!")
                        }
                    }
                }
            }
        }
    }
    @objc func gotoUpdateUser() {
        performSegue(withIdentifier: "fromHomeToUpdateUser", sender: self)
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameCell
        
        
        return cell.configure(with: games[indexPath.row])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scorllingValue = scrollView.contentOffset.y
        if scorllingValue > -80 {
            userImageView.alpha = 0
        }else {
            userImageView.alpha = 1
        }
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if  let uID = Auth.auth().currentUser?.uid, games[indexPath.row].user.id == uID {
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                
                let ref = Firestore.firestore().collection("Game")
                ref.document(self.games[indexPath.row].id).delete(completion: { error in
                    if let error = error {
                        print("Error in db delete",error)
                    } else {
                        DispatchQueue.main.async {
                            self.gamesTableView.reloadData()
                        }
                    }
                })
            }
            
            return UISwipeActionsConfiguration(actions: [action])
        }else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
}

