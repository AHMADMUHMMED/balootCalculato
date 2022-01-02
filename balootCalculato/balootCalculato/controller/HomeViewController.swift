//
//  HomeViewController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 28/05/1443 AH.
//
//
import UIKit
import Firebase
class HomeViewController: UIViewController {
//    var game = [Game]()
//    var selectedGame:Game?
//    var selectedGameImage:UIImage?
//
//    @IBOutlet weak var gamesTableView: UITableView! {
//        didSet {
//            gamesTableView.delegate = self
//            gamesTableView.dataSource = self
//            gamesTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getGames()
//        // Do any additional setup after loading the view.
//    }
//    func getGames() {
//        let ref = Firestore.firestore()
//        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
//            if let error = error {
//                print("DB ERROR Posts",error.localizedDescription)
//            }
//            if let snapshot = snapshot {
//                snapshot.documentChanges.forEach { diff in
//                    let post = diff.document.data()
//                    switch diff.type {
//                    case .added :
//                        if let userId = game["userId"] as? String {
//                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
//                                if let error = error {
//                                    print("ERROR user Data",error.localizedDescription)
//
//                                }
//                                if let userSnapshot = userSnapshot,
//                                   let userData = userSnapshot.data(){
//                                    let user = User(dict:userData)
//                                    let game = Game(dict:post,id:diff.document.documentID,user:user)
//                                    self.posts.insert(post, at: 0)
//                                    DispatchQueue.main.async {
//                                        self.postsTableView.reloadData()
//                                    }
//
//                                }
//                            }
//                        }
//                        case .modified:
//                        let postId = diff.document.documentID
//                        if let currentPost = self.game.first(where: {$0.id == postId}),
//                           let updateIndex = self.game.firstIndex(where: {$0.id == gameid}){
//                            let newGame = Game(dict:post, id: postId, user: currentPost.user)
//                            self.posts[updateIndex] = newGame
//                            DispatchQueue.main.async {
//                                self.postsTableView.reloadData()
//                            }
//                        }
//                    case .removed:
//                        let postId = diff.document.documentID
//                        if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
//                            self.posts.remove(at: deleteIndex)
//                            DispatchQueue.main.async {
//                                self.postsTableView.reloadData()
//                            }
//                        }
//                        }
//                    }
//                }
//            }
//        }
//        // old bad way
//        //    func getPosts() {
//        //        let ref = Firestore.firestore()
//        //        ref.collection("posts").addSnapshotListener { snapshot, error in
//        //            if let error = error {
//        //                print("DB ERROR Posts",error.localizedDescription)
//        //            }
//        //            if let snapshot = snapshot {
//        //                for document in snapshot.documents {
//        //                    let data = document.data()
//        //                    if let userId = data["userId"] as? String {
//        //                        ref.collection("users").document(userId).getDocument { userSnapshot, error in
//        //                            if let error = error {
//        //                                print("ERROR user Data",error.localizedDescription)
//        //
//        //                            }
//        //                            if let userSnapshot = userSnapshot,
//        //                               let userData = userSnapshot.data(){
//        //                                let user = User(dict:userData)
//        //                                let post = Post(dict:data,id:document.documentID,user:user)
//        //                                self.posts.append(post)
//        //                                DispatchQueue.main.async {
//        //                                    self.postsTableView.reloadData()
//        //                                }
//        //
//        //                            }
//        //                        }
//        //
//        //                    }
//        //                }
//        //            }
//        //        }
//        //    }
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

//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if let identifier = segue.identifier {
//                if identifier == "toPostVC" {
//                    let vc = segue.destination as! BalootCalculato
//                    vc.selectedPost = selectedPost
//                    vc.selectedPostImage = selectedPostImage
//                }else {
//                    let vc = segue.destination as! DetailsViewController
//                    vc.selectedPost = selectedPost
//                    vc.selectedPostImage = selectedPostImage
//                }
//            }
//
//        }
//    }
//
//    extension HomeViewController: UITableViewDataSource {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return posts.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
//            return cell.configure(with: posts[indexPath.row])
//        }
//
//
//    }
//    extension HomeViewController: UITableViewDelegate {
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 200
//        }
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let cell = tableView.cellForRow(at: indexPath) as! PostCell
//            selectedPostImage = cell.postImageView.image
//            selectedPost = posts[indexPath.row]
//            if let currentUser = Auth.auth().currentUser,
//               currentUser.uid == posts[indexPath.row].user.id{
//              performSegue(withIdentifier: "toPostVC", sender: self)
//            }else {
//                performSegue(withIdentifier: "toDetailsVC", sender: self)
//
//            }
//        }
    }
