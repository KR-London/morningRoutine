//
//  timetableCollectionViewCell.swift
//  morningRoutine
//
//  Created by Kate Roberts on 26/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import UIKit

class timetableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    required init(coder aDecoder: NSCoder)
            {
                super.init(coder: aDecoder)!
                setup()
            }
        
            override init(frame: CGRect)
            {
                super.init(frame: frame)
                setup()
        
            }
            
            func setup()
            {
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.cornerRadius = 5.0
                self.frame.size = CGSize(width: 400, height: 400)
               // self.frame.height = 100
                //self.frame.width = 100
            }
    
    func wobble(){
      //  UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: { self.transform = self.transform.scaledBy(x: 0.75, y: 0.75)}, completion: nil)
        pulse( view: self.contentView, sizeMultiplier: 2.0, duration: 0.2, repeatCount: 1000)
       // pulse( view: (self.inputView)!, sizeMultiplier: 2.0, duration: 0.2, repeatCount: 100)
        
    }
    
    func stopWobble(){
        self.contentView.layer.removeAllAnimations()
    }
}

func pulse(view: UIView, sizeMultiplier: Float, duration: TimeInterval, repeatCount: Float = 1.0) {
    let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
    pulseAnimation.duration = duration
    pulseAnimation.toValue = NSNumber(value: sizeMultiplier)
    pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    pulseAnimation.autoreverses = true
    pulseAnimation.repeatCount = repeatCount
    view.layer.add(pulseAnimation, forKey: nil)
}
