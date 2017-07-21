//
//  ScoreView.swift
//  Guess
//
//  Created by Robo Atenaga on 7/21/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import UIKit

class ScoreView: UILabel {
    // initial valueis set to 0
    var value:Int = 0 {
        // updated the text whenever value changes
        didSet {
            self.text = " \(value)"
        }
    }
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(font:frame:")
    }
    
    init(font:UIFont, frame:CGRect) {
        super.init(frame:frame)
        self.font = font
        self.backgroundColor = UIColor.clear
    }
}
