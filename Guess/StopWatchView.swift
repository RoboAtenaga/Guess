//
//  StopWatchView.swift
//  Guess
//
//  Created by Robo Atenaga on 7/20/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import UIKit

class StopWatchView: UILabel {
    
    //this should never be called
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.font = FontHUDBig
    }
    
    //helper method that implements time formatting
    //to an int parameter (eg the seconds left)
    func setSeconds(seconds:Int) {
        self.text = String(format: " %02i : %02i", seconds/60, seconds % 60)
    }
}
