//
//  Config.swift
//  Guess
//
//  Created by Robo Atenaga on 7/18/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import UIKit

//UI Constants
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let TileMargin: CGFloat = 15.0
let FontHUD = UIFont(name:"comic andy", size: 40.0)!
let FontHUDBig = UIFont(name:"comic andy", size: 80.0)!



//Random number generator
func randomNumber(minX: UInt32, maxX: UInt32) -> Int{
    let result = (arc4random() % (maxX - minX + 1) + minX)
    return Int(result)
}
