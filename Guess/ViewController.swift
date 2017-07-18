//
//  ViewController.swift
//  Guess
//
//  Created by Robo Atenaga on 7/18/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let controller: GameController

     required init(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let level1 = Level(levelNumber: 1)
        // Add a view to hold all game components
        let gameView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth))
        self.view.addSubview(gameView)
        
        controller.level = level1
        controller.gameView = gameView
        controller.dealRandomAnagram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

