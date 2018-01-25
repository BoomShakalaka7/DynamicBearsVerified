//
//  PauseViewController.swift
//  DynamicBears
//
//  Created by Marco Davide Fioretto on 12/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    var lives : [UIImageView] = []
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    var snapshot: UIImage!
    @IBOutlet weak var heart0: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    var secondi: Int = 0
    @IBOutlet weak var timerLabel: UILabel!
    
    // Top Constraints
    @IBOutlet var topConstraints: [NSLayoutConstraint]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = snapshot
        loadBlurredImage()
        scoreLabel.text = SessionController.score.description
        lives = [heart0, heart1, heart2]
        if SessionController.lives == 3 {
            print("You have all lives")
        }else if SessionController.lives == 2{
            heart2.isHighlighted=true
        }else if SessionController.lives == 1 {
            heart2.isHighlighted=true
            heart1.isHighlighted=true
        }else if SessionController.lives == 0 {
            heart2.isHighlighted=true
            heart1.isHighlighted=true
            heart0.isHighlighted=true
        }
        
        //        scoreLabel.text = SessionController.score.description
        // Do any additional setup after loading the view.
        
        // bug for iPhoneX
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            
            for i in 0..<topConstraints.count {
                let new: NSLayoutConstraint = topConstraints[i]
                new.constant = topConstraints[i].constant + topPadding!
                topConstraints[i] = new
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Singleton.shared.delegate = nil
    }
    
    func loadBlurredImage () {
        //        let transition: CATransition = CATransition()
        //        transition.duration = 1
        //        transition.timingFunction = backgroundView
        self.backgroundView.addBlurEffect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if secondi < 10 {
            timerLabel.text = "00:0\(secondi)"
        }else{
            timerLabel.text = "00:\(secondi)"
        }        
    }
    
    @IBAction func goBackToStart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainstart") as UIViewController
        SessionController.newGame()
        self.present(controller, animated: false, completion: nil)
        SessionController.score=0
        SessionController.lives=3
        SessionController.level = 1
        SessionController.round = 1
        Singleton.shared.seconds = 30
//        Singleton.shared.resetButtonTapped()
    }
    @IBAction func restartGame(_ sender: Any) {
        SessionController.newGame()
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        self.present(controller, animated: false, completion: nil)
        
        SessionController.score = 0
        SessionController.lives = 3
        SessionController.level = 1
        SessionController.round = 1
        Singleton.shared.seconds = 30
//        Singleton.shared.runTimer()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InfoScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InfoScreenViewController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
        
    }

    
    @IBAction func buttonPressed(_ sender: Any) {

        
        self.dismiss(animated: false, completion: nil)
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }

}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

