//
//  PackageViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 06/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController {
    let images : [UIImage] = [#imageLiteral(resourceName: "ok"),#imageLiteral(resourceName: "add")]
    var countIm : Int = 0
    var countIm2 : Int = 0
    @IBOutlet weak var mentorsCheckButton: UIButton!
    @IBOutlet weak var studentsCheckButton: UIButton!
    @IBOutlet weak var letsGoButton: UIButton!
    let whatPackage : [String] = [ "You have selected the mentors package","You have selected the students package","You have selected the students and mentors package","No package included" ]
    
    @IBAction func verifiedButton(_ sender: Any) {
        studentsCheckButton.setImage(images[countIm % images.count], for: .normal)
        self.checkPackages()
        if countIm == 0 {
            print("Students pack selected!")
            
        }else{
            print("Students pack deselected!")
            
        }
        
        if countIm < images.count-1{
            countIm=countIm+1
        }else{
            countIm = 0
        }
        self.checkPackages()
    }
    
    @IBAction func verifiedButtonMentors(_ sender: Any) {
        mentorsCheckButton.setImage(images[countIm2 % images.count], for: .normal)
        
        if countIm2 == 0 {
            print("Mentors pack selected!")
        }else{
            print("Mentors pack deselected!")
            
        }
        if countIm2 < images.count-1{
            countIm2=countIm2+1
        }else{
            countIm2 = 0
        }
        self.checkPackages()
    }
    func checkPackages(){
        if countIm == 0 && countIm2 == 1 {
            print("\(whatPackage[0])")
            SessionController.packetType = SessionController.PacketType.Mentors
            self.displayButton()
        }else if countIm2 == 0 && countIm == 1 {
            print("\(whatPackage[1])")
            SessionController.packetType = SessionController.PacketType.Students
            self.displayButton()
        }else if countIm == 1 && countIm2 == 1 {
            print("\(whatPackage[2])")
            SessionController.packetType = SessionController.PacketType.StudentsAndMentors
            self.displayButton()
        } else if countIm == 0 && countIm2 == 0 {
            print("\(whatPackage[3])")
            self.hideButton()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.letsGoButton.alpha = 0
        self.studentsCheckButton.alpha = 0
        self.mentorsCheckButton.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.studentsCheckButton.alpha = 1
            self.mentorsCheckButton.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func letsGoButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.letsGoButton.alpha = 0
            self.studentsCheckButton.alpha = 0
            self.mentorsCheckButton.alpha = 0
        }, completion: { (_) in
            let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
            self.present(controller, animated: true, completion: nil)
        })
    }
    
    func hideButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.letsGoButton.alpha = 0
        })
    }
    
    func displayButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.letsGoButton.alpha = 1
        })
    }
}
