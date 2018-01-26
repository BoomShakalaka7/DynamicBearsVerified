//
//  UIBuilder.swift
//  DynamicBears
//
//  Created by Arthur Lazzaretti on 15/12/2017.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import Foundation
import UIKit
public class UIBuilder {
    
    public static func loseLife(viewController: UIViewController, hearts: [UIImageView]) {
        SessionController.lives -= 1
        hearts[SessionController.lives].isHighlighted = true
        if (SessionController.lives == 0) {
            let storyboard = UIStoryboard(name: "Quiz", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Quiz") as UIViewController
            viewController.present(controller, animated: false, completion: nil)
        }
        
    }
    
    public static func buildRoundCards(view : UIView, scrollView : UIScrollView, selectedCards: [Card], contentWidth: inout CGFloat, labels: inout [UILabel]) {
        
        for (index,card) in selectedCards.enumerated() {
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
            
            
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height);
        labels = labels.shuffle
    }
    
}
