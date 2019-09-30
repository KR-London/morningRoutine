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
}
