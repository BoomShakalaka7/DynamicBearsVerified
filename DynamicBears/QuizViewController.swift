//
//  QuizViewController.swift
//  DynamicBears
//
//  Created by Ciro Sannino on 14/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController,UIScrollViewDelegate, TimerDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heart0: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    var currLabel : UILabel?
    var lives : [UIImageView] = []
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var contentWidth: CGFloat = 0.0
    var numImages = 4
    var selectedCardsMaybe : [Card]? = []
    var selectedCards : [Card] = []
    var labels = [UILabel] ()
    var gameIsStarted = true
    var nameLabel = UILabel()
    
    override func viewDidLoad(){
        Singleton.shared.delegate = self
        Singleton.shared.runTimer()
        
        
        super.viewDidLoad()
        scrollView.delegate = self
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
        
        
        selectedCards = CardController.getCardsNotOnThisLevel()
        
        pageControl.numberOfPages = selectedCards.count
        
        var index = 0
        
        for card in selectedCards {
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(index)
            contentWidth += view.frame.width
            
            
            //            //Shadow
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
            
            
            //            // Name and surname label
            
            
            
            let nameLabel = UILabel(frame: CGRect(x: 38, y: 488, width: 320, height: 30))
            nameLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
            nameLabel.textColor = UIColor.white
            nameLabel.text = "\(card.name) \(card.surname)"
            //            imageView.addSubview(nameLabel)
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
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height);
        labels = labels.shuffle
        currLabel = labels.remove(at: 0)
        view.addSubview(currLabel!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(375))
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {

        if Singleton.shared.resumeTapped == false {
            Singleton.shared.timer.invalidate()
            Singleton.shared.resumeTapped = true
        } else {
            Singleton.shared.runTimer()
            Singleton.shared.resumeTapped = false
        }
        
        let storyboard = UIStoryboard(name: "Pause", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PauseVC") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func choose(_ sender: Any) {
        //        if gameIsStarted==false {
        //        for label in labels {
        //            label.isHidden = true
        //        }
        
        //        let randomIndex = arc4random_uniform(UInt32(selectedCards.count))
        //        nameLabel = UILabel(frame: CGRect(x: 28, y: 487, width: 320, height: 30))
        //        nameLabel.font = UIFont.systemFont(ofSize: 25.0, weight: .medium)
        //        nameLabel.textColor = UIColor.white
        //        nameLabel.text = "\(selectedCards[Int(randomIndex)].name) \          (selectedCards[Int(randomIndex)].surname)"
        //            self.view.addSubview(nameLabel)
        //            gameIsStarted = true
        //            return
        let currCard = selectedCards[pageControl.currentPage]
        if (currCard.compare(currLabel!.text!)) {
            if (selectedCards.count == 1) {
                if (SessionController.cardsNotPlayedThisLevel.isEmpty) {
                    if (SessionController.hasCardsForNextLevel) {
                        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
                        SessionController.level += 1
                        SessionController.round = 1
                        self.present(controller, animated: true, completion: nil)
                    } else {
                        let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
                        self.present(controller, animated: true, completion: nil)
                        //SEGUE TO GAMEOVER SCREEN!!!!!!
                        //                        *******PROBLEM ******** WHEN YOU CHANGE LEVEL LIVES BECAME LIKE THE INITIAL PART ALSO IF WE
                        //               HAVE LOSE ONE
                    }
                    
                } else {
                    let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "Quiz") as UIViewController
                    SessionController.round += 1
                    self.present(controller, animated: false, completion: nil)
                }
                
                
                
            }
            else {
                labels = []
                contentWidth = 0.0
                selectedCards.remove(at: pageControl.currentPage)
                pageControl.numberOfPages -= 1
                UIBuilder.buildRoundCards(view: self.view, scrollView: scrollView, selectedCards: selectedCards, contentWidth: &contentWidth, labels: &labels)
                currLabel!.text! = labels.remove(at: 0).text!
            }
            
            //            view.addSubview(currLabel!)
            SessionController.score += 20 //SCORE YOU GET PER CORRECT CARD
            
        }else{
            SessionController.lives -= 1
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
                SessionController.lives=3
                let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
                self.present(controller, animated: false, completion: nil)
                
                
            }
        }
    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func timerElapsed() {
        timeLabel.text = "\(Singleton.shared.seconds)"
    }
    
    func reset() {
        let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
        self.present(controller, animated: false, completion: nil)
    }
    

}

//        else {
//        let selectedAnswer = "\(selectedCards[pageControl.currentPage].name) \(selectedCards[pageControl.currentPage].surname)"
//        if (selectedAnswer == nameLabel.text!) {
//        // Right answer
//        print("Brav")
//        SessionController.score += 100
//        } else {
//        // Wrong answer
//        print ("Caprone")
//        SessionController.lives -= 1
//        if SessionController.lives == 3 {
//        print("You have all lives")
//        }else if SessionController.lives == 2{
//        heart2.isHighlighted=true
//        }else if SessionController.lives == 1 {
//        heart2.isHighlighted=true
//        heart1.isHighlighted=true
//        }else if SessionController.lives == 0 {
//        heart2.isHighlighted=true
//        heart1.isHighlighted=true
//        heart0.isHighlighted=true
//        //                    check for dead!
//        }
//CHECK FOR DEAD, CHOOSE WHAT TO DO
//        }
//        }
//        }


//    var score  : Score = Score(userName: SessionController.userName!, score: 0, scoreType: 0)
//    ScoreController.postScore(score: score)


