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
        let controller = storyboard.instantiateInitialViewController() as! UIViewController
        
        self.present(controller, animated: false, completion: nil)
        
        
        
    }

    @IBOutlet weak var ScoreFirstLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        scoreLabel.text = SessionController.score.description
        super.viewDidLoad()
//        scoreLabel.text = SessionController.score.description
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
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
