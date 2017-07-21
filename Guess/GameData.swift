//
//  ScoreData.swift
//  Guess
//
//  Created by Robo Atenaga on 7/21/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
class GameData {
    //store the user's game achievement
    var points:Int = 0 {
        didSet {
            //custom setter - keep the score positive
            points = max(points, 0)
        }
    }
}
