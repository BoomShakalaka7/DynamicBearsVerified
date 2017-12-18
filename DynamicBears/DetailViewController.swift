//
//  DetailViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 16/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoPicture: UIImageView!
    
    var detailCard: Card? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCard = detailCard {
            if let infoLabel = infoLabel {
                infoLabel.text = detailCard.name
                infoPicture.image = detailCard.photo
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        configureView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
