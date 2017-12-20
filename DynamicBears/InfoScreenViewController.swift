//
//  InfoScreenViewController.swift
//  DynamicBears
//
//  Created by Luca Erviati on 19/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class InfoScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    @IBAction func showCredits(_ sender: Any) {
        performSegue(withIdentifier: "showcredits", sender: self)
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
