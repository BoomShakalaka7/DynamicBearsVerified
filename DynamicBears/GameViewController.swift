//
//  GameViewController.swift
//  DynamicBears
//
//  Created by Davide Maimone on 04/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIScrollViewDelegate {
  
    var lives : [UIImageView] = []
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var heart0: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    
    var contentWidth: CGFloat = 0.0
    var numImages = 4
    var selectedCardsMaybe : [Card]? = []
    var selectedCards : [Card] = []
    var labels = [UILabel] ()
    var gameIsStarted = false
    var nameLabel = UILabel()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(index)
            contentWidth += view.frame.width
            
            
            //Shadow
            //            let shadow = UIImageView(image: #imageLiteral(resourceName: "cardShadow"))
            //            shadow.frame = CGRect(x: xCoordinate-187.5, y: (view.frame.height/2)-333, width: 375, height: 520)
            //            scrollView.addSubview(shadow)
            
            //Image
            let imageToDisplay = card.photo
            let imageView = UIImageView(image: imageToDisplay)
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate-177.3, y: (view.frame.height/2)-326, width: 375*0.945, height: 520*0.965)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 15
            
            //Black Gradient
            let gradient = UIImageView(image: #imageLiteral(resourceName: "cardGradient"))
            gradient.frame = CGRect(x: -1, y: 368, width: 375*0.96, height: 142)
            gradient.clipsToBounds = true
            gradient.layer.cornerRadius = 15
            imageView.addSubview(gradient)
            
            
            // Name and surname label
            let nameLabel = UILabel(frame: CGRect(x: 15, y: 425, width: 320, height: 30))
            nameLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
            nameLabel.textColor = UIColor.white
            nameLabel.text = "\(card.name) \(card.surname)"
            imageView.addSubview(nameLabel)
            labels.append(nameLabel)
            
            
            
            // Job label
            let jobLabel = UILabel(frame: CGRect(x: 15, y: 455, width: 320, height: 30))
            jobLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .light)
            jobLabel.textColor = UIColor.white
            jobLabel.text = card.description
            imageView.addSubview(jobLabel)
            labels.append(jobLabel)
            
            
            index = index+1
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(375))
        if pageControl.currentPage == 3{
            playButton.isHidden = false
            infoLabel.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        //        self.performSegue(withIdentifier: "pauseVC", sender: self)
        
        let storyboard = UIStoryboard(name: "Pause", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PauseVC") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
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

//    var score  : Score = Score(userName: SessionController.userName!, score: 0, scoreType: 0)
//    ScoreController.postScore(score: score)
    
    
    
    
