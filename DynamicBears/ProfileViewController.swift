//
//  ProfileViewController.swift
//  DynamicBears
//
//  Created by Ciro Sannino on 18/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var hasUserName = true;
    @IBOutlet var lblTopNames: [UILabel]!
    
    
    @IBOutlet weak var lblLoadingScores: UILabel!
    @IBOutlet weak var viewLoadingScores: UIView!
    @IBOutlet var lblTopScores: [UILabel]!
    @IBOutlet weak var lblYourTopScore: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var lblUserName: UILabel!
    override func viewDidLoad() {
        viewLoadingScores.layer.borderColor = UIColor.blue.cgColor
        viewLoadingScores.layer.borderWidth = 1
        super.viewDidLoad()
        if (SessionController.userName == nil) {
            profileView.isHidden = true;
            hasUserName = false
            
        } else {
            lblUserName.text = SessionController.userName
            viewLoadingScores.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (hasUserName) {
            
            
            
            let myScores = ScoreController.getMyTop5Scores(userName: SessionController.userName!)
            if (myScores.isEmpty) {
                lblLoadingScores.text = "Error connecting to server"
                
                
                
            } else {
                lblYourTopScore.text = myScores[0].score.description
                let topScores = ScoreController.getTop5Scores()
                for (index, score) in topScores.enumerated() {
                    lblTopNames[index].text = score.userName
                    lblTopScores[index].text = score.score.description
                }
                viewLoadingScores.isHidden = true
                
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
