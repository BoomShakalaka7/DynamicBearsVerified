//
//  GameOverViewController.swift
//  DynamicBears
//
//  Created by Ciro Sannino on 14/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    let notification = UINotificationFeedbackGenerator()
    @IBOutlet weak var viewPickUserName: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var lblErrorString: UILabel!
    @IBOutlet weak var lblUserNameError: UILabel!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBAction func pickUserNameButtonPress(_ sender: Any) {
        let newUserName = txtUserName.text
        if (newUserName != nil && !newUserName!.isEmpty && !newUserName!.contains(" ")) {
            
            
            if (ScoreController.isUserNameAvailable(userName: newUserName!)) {
                SessionController.userName = newUserName!;
                viewPickUserName.isHidden = true;
                btnRetry.isEnabled = true;
                btnHome.isEnabled = true;
                txtUserName.resignFirstResponder()
                let thisScore = Score(userName: SessionController.userName!, score: SessionController.score, scoreType: 0)
                
                ScoreController.postScore(score: thisScore)
                
            } else {
                lblErrorString.text = "This name is taken"
                notification.notificationOccurred(.error)
                
            }
            
            
        } else {
            lblErrorString.text = "Please enter a valid name"
            notification.notificationOccurred(.error)
        }
        
        
    }
    
    
    @IBAction func retryButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        
        self.present(controller, animated: false, completion: nil)
        SessionController.score = 0
        SessionController.lives = 3
        SessionController.level = 1
        SessionController.round = 1
        SessionController.newGame()
        
        
        
        
    }
    @IBOutlet weak var scoreofMatch: UILabel!
    @IBAction func goOnTheMainStoryBoard(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainstart") as UIViewController
        self.present(controller, animated: false, completion: nil)
        SessionController.score = 0
        SessionController.newGame()
        SessionController.lives = 3
        SessionController.level = 1
        SessionController.round = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (SessionController.userName == nil) {
            viewPickUserName.layer.cornerRadius = 10
            viewPickUserName.layer.masksToBounds = true
            viewPickUserName.isHidden = false;
            btnRetry.isEnabled = false;
            btnHome.isEnabled = false;
            txtUserName.becomeFirstResponder()
        } else {
            let thisScore = Score(userName: SessionController.userName!, score: SessionController.score, scoreType: 0)
            
            ScoreController.postScore(score: thisScore)
        }
        
        
        scoreofMatch.text! = SessionController.score.description
        
        
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
