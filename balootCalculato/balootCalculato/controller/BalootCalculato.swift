import UIKit
import Firebase
class BalootCalculato: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedPost:Game?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var usTextField: UITextField!
    @IBOutlet weak var themTextField: UITextField!
    @IBOutlet weak var usLebl: UILabel!
    @IBOutlet weak var themLebl: UILabel!
    @IBOutlet weak var usResultBG: UIView!
    @IBOutlet weak var themResultBG: UIView!
    @IBOutlet weak var calcBut: UIButton!
    @IBOutlet weak var undoBut: UIButton!
    @IBOutlet weak var newGameBut: UIButton!
    @IBOutlet weak var redoBut: UIButton!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var usTopLbl: UILabel!
    @IBOutlet weak var themTopLbl: UILabel!
    @IBOutlet weak var usTVLbl: UILabel!
    @IBOutlet weak var themTVLbl: UILabel!
    @IBOutlet weak var btnsBackgroundView: UIView!
    @IBOutlet weak var usResultLbl: UILabel!
    @IBOutlet weak var usCont: UIView!
    @IBOutlet weak var themResultLbl: UILabel!
    @IBOutlet weak var themCont: UIView!
    @IBOutlet weak var distributerBtn: UIButton!
    var redoMode = false
    var darkMode : Bool {
        get {
            return UserDefaults.standard.bool(forKey: "darkMode") ? true : false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "darkMode")
            UserDefaults.standard.synchronize()
        }
    }
    let calculator = gameReference.instance
    override func viewDidLoad() {
        super.viewDidLoad()
        //    Translation الترجمة
        calcBut.setTitle("calculator".localiz, for: .normal)
        undoBut.setTitle("back".localiz, for: .normal)
        newGameBut.setTitle("newGame".localiz, for: .normal)
        usTopLbl.text = "us".localiz
        themTopLbl.text = "them".localiz
        usTVLbl.text = "us".localiz
        themTVLbl.text = "them".localiz
        themResultLbl.text = "them".localiz
        usResultLbl.text = "us".localiz
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        // register custome cells
        tableView.register(UINib.init(nibName: "ScoreCell", bundle: nil), forCellReuseIdentifier: "ScoreCell")
        tableView.register(UINib.init(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        if(self.darkMode){
            self.applyDarkMode()
            
           
        }
        updateUI()
        // to select winner
        if let player1 = Int(usLebl.text!), let player2 = Int(themLebl.text!) {
            if player1 > player2 {
                winnerNameLabel.text = "لهم"
                
}else{
    winnerNameLabel.text = "لنا"
        }
           }
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculator.result.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = calculator.result[indexPath.row]
        if(score.type == .score) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
            cell.configure(score: score)
            return cell
        } else if(score.type == .result) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            cell.configure(score: score)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    @IBAction func postButeen(_ sender: Any) {
        let db = Firestore.firestore()
        let selectedPost = self.selectedPost
        if let us = usLebl.text,
           let them = themLebl.text,
           let winner = winnerNameLabel.text,
           let userId = Auth.auth().currentUser?.uid{
            var ref: DocumentReference? = nil
            ref = db.collection("Game").addDocument(data: [
                "us": us,
                "them": them,
                "winner": winner,
                "userId":userId,
                "createdAt":selectedPost?.createdAt ?? FieldValue.serverTimestamp(),
                "updatedAt": FieldValue.serverTimestamp()
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }
    @IBAction func calculate(_ sender: Any) {
        if((usTextField.text == nil || usTextField.text == "") && (themTextField.text == nil || themTextField.text == "")) {
            view.endEditing(true)
            return;
        }
        let themScore = themTextField.text == nil || themTextField.text == "" ? 0 : Int((themTextField.text! as NSString).intValue)
        let usScore = usTextField.text == nil || usTextField.text == "" ? 0 : Int((usTextField.text! as NSString).intValue)
        
        
        calculator.add(us:usScore, them:themScore)
        themTextField.text = ""
        usTextField.text = ""
        self.updateUI()
        self.checkWinner()
    }
    
    @IBAction func newSaka(_ sender: Any) {
        let alert = UIAlertController(title: "هل أنت متأكد من بداية صكة جديدة؟", message: nil, preferredStyle: .alert);
        let yesAction = UIAlertAction(title: "نعم", style: .cancel) { (action) in
            self.calculator.newGame()
            self.updateUI()
        }
        let cancelAction = UIAlertAction(title: "إلغاء", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil);
    }
    
    @IBAction func undo(_ sender: Any) {
        calculator.undo()
        self.updateUI()
        
    }
    
    @IBAction func redo(_ sender: Any) {
        calculator.redo()
        self.updateUI()
    }
    
    
    
    func updateUI() {
        if (calculator.currentScore.them == 0){
            themLebl.text = "0"
        } else {
            themLebl.text = "\(calculator.currentScore.them)"
        }
        
        if (calculator.currentScore.us == 0){
            usLebl.text = "0"
        } else {
            usLebl.text = "\(calculator.currentScore.us)"
        }
        
        tableView.reloadData()
        if(calculator.result.count > 0){
            let indexPath = IndexPath(row: self.calculator.result.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
        if(calculator.hasRedo && !self.redoMode) {
            // go redo mode
//            undoWidthConstrain.constant = 100
            undoBut.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0);
            redoBut.isHidden = false
            redoMode = true
        } else if(!calculator.hasRedo && self.redoMode) {
            // back to regular mode
//            undoWidthConstrain.constant = 80
            undoBut.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            redoBut.isHidden = true
            redoMode = false
        }
        switch calculator.distributer {
        case .me:
            distributerBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        case .right:
            distributerBtn.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        case .front:
            distributerBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 3/2))
        default:
            distributerBtn.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        
        view.endEditing(true)
        
    }
    
    func checkWinner() {
        let usScore = calculator.currentScore.us
        let themScore = calculator.currentScore.them
        
        if(usScore < 152 && themScore < 152) || (usScore == 152 && themScore == 152) {
            return
        }
        
        if(usScore >= 152 && usScore > themScore){
            let alert = UIAlertController(title: "مبروك الفوز", message: "قامت لكم.. هل تريد بدء صكة جديدة؟", preferredStyle: .alert)
            let newSakaAction = UIAlertAction(title: "نعم", style: .cancel, handler: { (action) in
                self.calculator.newGame()
                self.updateUI()
            })
            let noAction = UIAlertAction(title: "لا", style: .default, handler: nil)
            
            alert.addAction(newSakaAction)
            alert.addAction(noAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        if(themScore >= 152 && themScore > usScore) {
            let alert = UIAlertController(title: "خيرها في غيرها", message: "قامت لهم.. هل تريد بدء صكة جديدة؟", preferredStyle: .alert)
            let newSakaAction = UIAlertAction(title: "نعم", style: .cancel, handler: { (action) in
                self.calculator.newGame()
                self.updateUI()
            })
            let noAction = UIAlertAction(title: "لا", style: .default, handler: nil)
            
            alert.addAction(newSakaAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundView?.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(calculator.result[indexPath.row].type == .score) {
            return 25
        } else if (calculator.result[indexPath.row].type == .result && calculator.result.count - 1 == indexPath.row) {
            return 50
        } else {
            return 30
        }
        
    }
    
    func applyDarkMode(){
        backgroundImg.image = #imageLiteral(resourceName: "Dark Background")
        calcBut.backgroundColor = UIColor(white: 255.0/255.0, alpha: 1.0)
        calcBut.setTitleColor(UIColor(white: 0.0, alpha: 1.0), for: .normal)
        usTopLbl.textColor = UIColor(white: 155.0/255.0, alpha: 1.0)
        themTopLbl.textColor = UIColor(white: 155.0/255.0, alpha: 1.0)
        usTVLbl.textColor = UIColor(white: 166.0/255.0, alpha: 1.0)
        themTVLbl.textColor = UIColor(white: 166.0/255.0, alpha: 1.0)
        btnsBackgroundView.backgroundColor = UIColor(white: 0.0/255.0, alpha: 0.4)
        usResultLbl.textColor = UIColor(white: 255.0/255.0, alpha: 0.44)
        usResultBG.borderColor = UIColor(white: 255.0/255.0, alpha: 0.44)
        themResultLbl.textColor = UIColor(red: 251.0/255.0, green: 104.0/255.0, blue: 104.0/255.0, alpha: 0.7)
        themResultBG.borderColor = UIColor(red: 251.0/255.0, green: 104.0/255.0, blue: 104.0/255.0, alpha: 0.6)
        usLebl.textColor = UIColor(red: 226.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        themLebl.textColor = UIColor(red: 226.0/255.0, green: 222.0/255.0, blue: 222.0/255.0, alpha: 1.0)
    }
    func applyRegularMode(){
        backgroundImg.image = #imageLiteral(resourceName: "Dark Background")
        calcBut.backgroundColor = UIColor(white: 53.0/255.0, alpha: 1.0)
        calcBut.setTitleColor(UIColor(white: 255.0/255.0, alpha: 1.0), for: .normal)
        usTopLbl.textColor = UIColor(white: 74.0/255.0, alpha: 1.0)
        themTopLbl.textColor = UIColor(white: 74.0/255.0, alpha: 1.0)
        usTVLbl.textColor = UIColor(white: 74.0/255.0, alpha: 1.0)
        themTVLbl.textColor = UIColor(white: 74.0/255.0, alpha: 1.0)
        btnsBackgroundView.backgroundColor = UIColor(white: 203.0/255.0, alpha: 0.7)
        usResultLbl.textColor = UIColor(white: 69.0/255.0, alpha: 0.6)
        usResultBG.borderColor = UIColor(white: 69.0/255.0, alpha: 0.44)
        themResultLbl.textColor = UIColor(red: 248.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 0.6)
        themResultBG.borderColor = UIColor(red: 248.0/255.0, green: 89.0/255.0, blue: 89.0/255.0, alpha: 0.44)
        usLebl.textColor = UIColor(white: 0.0/255.0, alpha: 0.6)
        themLebl.textColor = UIColor(white: 0.0/255.0, alpha: 0.6)
    }
    @IBAction func darkModeToggle(_ sender: Any) {
        if(!self.darkMode) {
            // to dark mode
            applyDarkMode()
            darkMode = true
        } else {
            // to regular mode
            applyRegularMode()
            darkMode = false
        }
    }
    
    
    @IBAction func changeDistributer(_ sender: Any) {
        calculator.moveDistributer()
        updateUI()
    }
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
