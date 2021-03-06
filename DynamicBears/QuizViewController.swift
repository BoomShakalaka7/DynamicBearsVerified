//
//  QuizViewController.swift
//  DynamicBears
//
//  Created by Ciro Sannino on 14/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var lblCurrRound: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heart0: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    var currLabel : UILabel?
    var lives : [UIImageView] = []
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Top Constraint
    @IBOutlet var topContraints: [NSLayoutConstraint]!
    
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var contentWidth: CGFloat = 0.0
    var numImages = 4
    var selectedCardsMaybe : [Card]? = []
    var selectedCards : [Card] = []
    var labels = [UILabel] ()
    var gameIsStarted = true
    var nameLabel = UILabel()
    var timer = Timer()
    
    override func viewDidLoad(){
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
            
            let imageWidth : CGFloat = 375*0.945
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(index)
//            let yCoordinate = view.frame.midY
            contentWidth += view.frame.width
//            let ratio = self.view.frame.height
            
            
            //            //Shadow
            //            let shadow = UIImageView(image: #imageLiteral(resourceName: "cardShadow"))
            //            shadow.frame = CGRect(x: xCoordinate-187.5, y: (view.frame.height/2)-333, width: 375, height: 520)
            //            scrollView.addSubview(shadow)
            
            //Image
            let imageToDisplay = card.photo
            let imageView = UIImageView(image: imageToDisplay)
            
            let imageHeight : CGFloat = 520*0.965
//            let imageY : CGFloat = (ratio / 2) - (ratio / 2.046)
//            let imageY2 : CGFloat = (ratio / 2) - (imageHeight / 2)
            imageView.frame = CGRect(x: xCoordinate - imageWidth / 2, y:0, width: imageWidth, height: imageHeight)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 15
            
            scrollView.addSubview(imageView)
            
            
            //Black Gradient
            let gradient = UIImageView(image: #imageLiteral(resourceName: "cardGradient"))
            gradient.frame = CGRect(x: -1, y: 368, width: 375*0.96, height: 142)
            gradient.clipsToBounds = true
            gradient.layer.cornerRadius = 15
            imageView.addSubview(gradient)
            
            
            //            // Name and surname label
            
            let nameLabel = UILabel(frame: CGRect(x: scrollView.frame.minX + 28, y: scrollView.frame.minY + 420 , width: 320, height: 30))
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
        
        // bug for iPhoneX
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            
            for i in 0..<topContraints.count {
                let new: NSLayoutConstraint = topContraints[i]
                new.constant = topContraints[i].constant + topPadding!
                topContraints[i] = new
                
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        lblCurrRound.text! += SessionController.round.description
        UIView.animate(withDuration: 0.6, animations: {
            self.lblCurrRound.alpha = 0
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runTimer()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        Singleton.shared.seconds -= 1
        if Singleton.shared.seconds == 0 {
            resetTimer()
            let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
            self.present(controller, animated: true, completion: nil)
        } else {
            if Singleton.shared.seconds < 10 {
                timeLabel.text = "00:0\(Singleton.shared.seconds)"
            }else{
                timeLabel.text = "00:\(Singleton.shared.seconds)"
            }
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        Singleton.shared.seconds = 30
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(375))
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {

        
        timer.invalidate()
       
        let img =  UIImage.init(view: mainView)
        
        let storyboard = UIStoryboard(name: "Pause", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PauseVC") as! PauseViewController
        controller.secondi = Singleton.shared.seconds
        controller.snapshot = img
        self.present(controller, animated: false, completion: nil)
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
                        resetTimer()
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
//            haptic feedback
            notification.notificationOccurred(.error)
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
                notification.notificationOccurred(.error)
                let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
                self.present(controller, animated: false, completion: nil)
                
                
            }
        }
    }
    
    
    
    let notification = UINotificationFeedbackGenerator()//haptic feedback
    
    func timerElapsed() {
            if Singleton.shared.seconds < 10 {
                timeLabel.text = "00:0\(Singleton.shared.seconds)"
            }else{
                timeLabel.text = "00:\(Singleton.shared.seconds)"
            }
        }
    
    func reset() {
        let storyboard = UIStoryboard(name: "GameOver", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "gameOver") as UIViewController
        self.present(controller, animated: false, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
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


