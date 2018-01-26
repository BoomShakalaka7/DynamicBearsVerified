//
//  CardViewerViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 04/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class CardViewerViewController: UIViewController, UIScrollViewDelegate {
  
    @IBOutlet weak var lblCurrLevel: UILabel!
    @IBOutlet weak var viewLevelTransition: UIView!
    var lives : [UIImageView] = []
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var heart0: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet var mainView: UIView!
    
    var contentWidth: CGFloat = 0.0
    var numImages = 4
    var selectedCardsMaybe : [Card]? = []
    var selectedCards : [Card] = []
    var labels = [UILabel] ()
    var gameIsStarted = false
    var nameLabel = UILabel()
    
    // Top Constraints
    @IBOutlet var topConstraints: [NSLayoutConstraint]!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()

        lblCurrLevel.text = SessionController.level.description
        scrollView.delegate = self
//        make play button hide
        playButton.isHidden = true
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
        
        selectedCardsMaybe = CardController.getCardsNewLevel()
        if selectedCardsMaybe == nil {
            let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
            self.present(controller, animated: false, completion: nil)
            //SEGUE TO END SCREEN PRINT SCORE
            
            print("ERROR RETRIEVING CARDS")
        }
        
        selectedCards = selectedCardsMaybe!
        
        pageControl.numberOfPages = selectedCards.count
        //        pageControl.currentPage = (SessionController.level - 1) * 3
        var index = 0
        for card in selectedCards {
            
            let imageWidth : CGFloat = 375*0.945
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(index)
            let yCoordinate = view.frame.midY
            contentWidth += view.frame.width
            let ratio = self.view.frame.height
            
            
            //            //Shadow
            //            let shadow = UIImageView(image: #imageLiteral(resourceName: "cardShadow"))
            //            shadow.frame = CGRect(x: xCoordinate-187.5, y: (view.frame.height/2)-333, width: 375, height: 520)
            //            scrollView.addSubview(shadow)
            
            //Image
            let imageToDisplay = card.photo
            let imageView = UIImageView(image: imageToDisplay)
            scrollView.addSubview(imageView)
            let imageHeight : CGFloat = 520*0.965
            let imageY : CGFloat = (ratio / 2) - (ratio / 2.046)
            let imageY2 : CGFloat = (ratio / 2) - (imageHeight / 2)
            imageView.frame = CGRect(x: xCoordinate - imageWidth / 2, y:0, width: imageWidth, height: imageHeight)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 15
            
            
            //Black Gradient
            let gradient = UIImageView(image: #imageLiteral(resourceName: "cardGradient"))
            gradient.frame = CGRect(x: -1, y: 368, width: 375*0.96, height: 142)
            gradient.clipsToBounds = true
            gradient.layer.cornerRadius = 15
            imageView.addSubview(gradient)
            
            
            //            // Name and surname label
            
            let nameLabel = UILabel(frame: CGRect(x: 25, y: 420, width: 320, height: 30))
            nameLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
            nameLabel.textColor = UIColor.white
            nameLabel.text = "\(card.name) \(card.surname)"
            imageView.addSubview(nameLabel)
            labels.append(nameLabel)
            
            
            
            // Job label
            let jobLabel = UILabel(frame: CGRect(x: 28, y: 455, width: 320, height: 30))
            jobLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .light)
            jobLabel.textColor = UIColor.white
            jobLabel.text = card.description
            imageView.addSubview(jobLabel)
            //            labels.append(jobLabel)
            
            
            index = index+1
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
        
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
    

    override func viewDidAppear(_ animated: Bool) {
//        self.view.bringSubview(toFront: viewLevelTransition)
               UIView.animate(withDuration: 0.8, animations: {
           self.viewLevelTransition.alpha = 0
        })
//        UIView.animate(withDuration: 0.2, animations: {
//            self.viewLevelTransition.alpha = 0
//        })
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(self.view.frame.width))
        if pageControl.currentPage == 3{
            playButton.isHidden = false
            infoLabel.isHidden = true
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        //        self.performSegue(withIdentifier: "pauseVC", sender: self)
        
        let img =  UIImage.init(view: mainView)
        
        let storyboard = UIStoryboard(name: "Pause", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PauseVC") as! PauseViewController
        controller.snapshot = img
        self.present(controller, animated: false, completion: nil)
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Quiz") as UIViewController
        
        self.present(controller, animated: false, completion: nil)
        
        
        
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
}

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}
