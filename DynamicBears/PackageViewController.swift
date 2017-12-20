//
//  PackageViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 06/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController {
   let notification = UINotificationFeedbackGenerator() //haptic feedback
    
    let images : [UIImage] = [#imageLiteral(resourceName: "ok"),#imageLiteral(resourceName: "add")]
    var countIm : Int = 0
    var countIm2 : Int = 0
    @IBOutlet weak var mentorsCheckButton: UIButton!
    @IBOutlet weak var studentsCheckButton: UIButton!
    @IBOutlet weak var letsGoButton: UIButton!
    let whatPackage : [String] = [ "You have selected the mentors package","You have selected the students package","You have selected the students and mentors package","No package included" ]
    
    @IBAction func verifiedButton(_ sender: Any) {
        studentsCheckButton.setImage(images[countIm % images.count], for: .normal)
        notification.notificationOccurred(.success) //haptic feedback
        countIm+=1
        if countIm == 1 {
            print("Students pack selected!")
            self.displayButton()
            
        }else{
            print("Students pack deselected!")
            
        }
        
        if countIm >= images.count{
          countIm = 0
        }
        
    }
    
    @IBAction func verifiedButtonMentors(_ sender: Any) {
        mentorsCheckButton.setImage(images[countIm2 % images.count], for: .normal)
        notification.notificationOccurred(.success) //haptic feedback
        countIm2+=1
        if countIm2 == 1 {
            print("Mentors pack selected!")
            self.displayButton()
        }else{
            print("Mentors pack deselected!")
            
        }
        if countIm2 >= images.count{
            countIm2=0
       }
    }
   func checkPackages(){
        if countIm==1 {
            SessionController.packetType=SessionController.PacketType.Students
        }else{
            SessionController.packetType=SessionController.PacketType.Mentors
        }
            
        if countIm2==1{
            SessionController.packetType=SessionController.PacketType.Mentors
        
        }else{
            SessionController.packetType=SessionController.PacketType.Students
        }
    
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPackages()
    
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
        print("\(countIm)")
            print("\(countIm2)")
        checkPackages()
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
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
