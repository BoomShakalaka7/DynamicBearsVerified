//
//  PauseViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 11/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
