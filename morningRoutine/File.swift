//
//  File.swift
//  morningRoutine
//
//  Created by Kate Roberts on 30/09/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

import Foundation


enum taskStatus: String{
    case Open
    case Closed
    case Snoozed
    
    func check() -> String{
        return self.rawValue
    }
    
}
