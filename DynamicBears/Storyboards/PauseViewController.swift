//
//  PauseViewController.swift
//  DynamicBears
//
//  Created by Marco Davide Fioretto on 12/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {

    @IBAction func goBackToStart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainstart") as UIViewController
        SessionController.newGame()
        self.present(controller, animated: false, completion: nil)
        SessionController.score=0
        SessionController.lives=3
        
    }
    @IBAction func restartGame(_ sender: Any) {
        SessionController.newGame()
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        self.present(controller, animated: false, completion: nil)
        
        SessionController.score = 0
        SessionController.lives = 3
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InfoScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InfoScreenViewController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        scoreLabel.text = SessionController.score.description
        super.viewDidLoad()
        //        scoreLabel.text = SessionController.score.description
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        if Singleton.shared.resumeTapped == false {
            Singleton.shared.timer.invalidate()
            Singleton.shared.resumeTapped = true
        } else {
            Singleton.shared.runTimer()
            Singleton.shared.resumeTapped = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
