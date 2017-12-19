//
//  GameOverViewController.swift
//  DynamicBears
//
//  Created by Ciro Sannino on 14/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBAction func retryButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        
        self.present(controller, animated: false, completion: nil)
        SessionController.score = 0
        SessionController.lives = 3
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
