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
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(index)
            contentWidth += view.frame.width

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
            
            
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height);
        labels = labels.shuffle
    }
    
}
