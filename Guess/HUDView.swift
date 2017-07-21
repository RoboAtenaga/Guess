//
//  HUDView.swift
//  Guess
//
//  Created by Robo Atenaga on 7/20/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import UIKit

// View to hold other contents like stopwatch, hint button, scores etc
class HUDView: UIView {
    
    var stopwatch: StopWatchView
    var scoreLabel: ScoreView
    
    //this should never be called
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        self.stopwatch = StopWatchView(frame:CGRect(x: ScreenWidth/3, y: 0, width: 300, height: 100))
        self.stopwatch.setSeconds(seconds: 0)
        
        //the score label
        self.scoreLabel = ScoreView(font: FontHUD, frame: CGRect(x: ScreenWidth * 0.18, y: 30, width: 200, height: 70))
        scoreLabel.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        scoreLabel.value = 0
        
        super.init(frame:frame)
        self.addSubview(self.stopwatch)
        self.addSubview(scoreLabel)
        
        //"points:" label
        let pointsLabel = UILabel(frame: CGRect(x: ScreenWidth * 0.025, y: 30, width: 140,height: 70))
        pointsLabel.backgroundColor = UIColor.clear
        pointsLabel.font = FontHUD
        pointsLabel.text = " Points:"
        self.addSubview(pointsLabel)
        // so that we can't move contents around
        self.isUserInteractionEnabled = false
    }
}
