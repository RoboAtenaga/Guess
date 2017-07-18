//
//  TileView.swift
//  Guess
//
//  Created by Robo Atenaga on 7/18/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import  UIKit

// Protocols provide a blueprint for Methods, properties and other requirements functionality.
// Declare a protocol with a single method.
protocol TileDragDelegateProtocol {
    func tileViewDragged(tileView: TileView, didDragToPoint: CGPoint)
}

class TileView: UIImageView {

    var letter: Character
    private var yDragOffset: CGFloat = 0.0
    private var xDragOffset: CGFloat = 0.0
    var dragDelegate: TileDragDelegateProtocol?
    
    // isMatched is to check if a tile letter matches the slot letter
    var isMatches: Bool = false
    
    // this should never be called
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    // Create a new tile for a given letter
    init(letter:Character, sideLength:CGFloat) {
        self.letter = letter
        
        //the tile background
        let image = UIImage(named: "tile")!
        
        //superclass initializer
        //references to superview's "self" must take place after super.init
        super.init(image:image)
        
        // Resize the tile, because phrases aren't the same length
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
        
        // Show the letter on the tile
        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.center
        letterLabel.textColor = UIColor.white
        letterLabel.backgroundColor = UIColor.clear
        letterLabel.text = String(letter).uppercased()
        letterLabel.font = UIFont(name: "Verdana-Bold", size: 78.0*scale)
        self.addSubview(letterLabel)
        
        // Enable user interaction
        self.isUserInteractionEnabled =  true
    }
        
    // Randomly rotate the tiles just for fun
    func randomize() {
        // Set random rotation of the tile anywhere between -0.2 and 0.3 radians
        let rotation = CGFloat(randomNumber(minX:0, maxX:50)) / 100.0 - 0.2
        self.transform = CGAffineTransform(rotationAngle: rotation)
        
        // Move randomly upwards using values between -10 and 0
        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPoint(x: self.center.x, y: self.center.y + yOffset)
    }
    
    // When a touch is detected, get its location within the tile’s superview, calculate 
    // and store the distance from the touch to the tile’s center.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.superview)
            xDragOffset = point.x - self.center.x
            yDragOffset = point.y - self.center.y
        }
    }
    
    // When player moves their finger, move the tile to that location, but adjust the location by the 
    // offsets stored, this keeps the tile from centering itself under the player’s finger as soon as they start moving it.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self.superview)
            self.center = CGPoint(x: point.x - xDragOffset, y: point.y - yDragOffset)
        }
    }
    
    // When the player lifts their finger, call touchesMoved to make sure the tile’s 
    // position is set to the touch’s final location.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesMoved(touches, with: event)
        dragDelegate?.tileViewDragged(tileView: self, didDragToPoint: self.center)
    }

}

