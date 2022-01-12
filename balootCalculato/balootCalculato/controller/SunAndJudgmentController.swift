//
//  SunAndJudgmentController.swift
//  balootCalculato
//
//  Created by Ahmad Barqi on 09/06/1443 AH.
//

import UIKit

class SunAndJudgmentController: UIViewController {
    @IBOutlet weak var sunBut: UIButton!
    
    @IBOutlet weak var orInTheLebal: UILabel!
    
    
    @IBOutlet weak var judgmentBut: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orInTheLebal.text = "or".localiz
        sunBut.setTitle("sun".localiz, for: .normal)
        judgmentBut.setTitle("judgment".localiz, for: .normal)
        
        
        
        
        
        
        // Do any additional setup after loading the view.
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
