//
//  GameController.swift
//  Guess
//
//  Created by Robo Atenaga on 7/18/17.
//  Copyright © 2017 Robo Atenaga. All rights reserved.
//

import Foundation
import UIKit

class GameController {
    var gameView: UIView!
    var level: Level!
    var tiles = [TileView]()
    var slots = [SlotView]()
    
    init() {
    }
    
    func dealRandomAnagram() {
        // Make sure level object contains anagrams
        assert(level.anagrams.count > 0, "no level loaded")
        
        // Generate a random index using func randonNumber in Config.swift file
        let randomIndex = randomNumber(minX:0, maxX:UInt32(level.anagrams.count-1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        let anagram1Length = anagram1.characters.count
        let anagram2Length = anagram2.characters.count
        
        // Calculate the tile size
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1Length, anagram2Length))) - TileMargin
        
        // Calculate the left margin for first tile
        var xOffset = (ScreenWidth - CGFloat(max(anagram1Length, anagram2Length)) * (tileSide + TileMargin)) / 2.0
        // Adjust for tile center (instead of the tile's origin)
        xOffset += tileSide / 2.0
        
        // Initialize slots list
        slots = []
        
        // Create slots
        for (index, letter) in anagram2.characters.enumerated() {
            if letter != " " {
                let slot = SlotView(letter: letter, sideLength: tileSide)
                slot.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + TileMargin), y: ScreenHeight * 0.5)
                
                // Add the slot to the gameView
                gameView.addSubview(slot)
                slots.append(slot)
            }
        }

        // Initialize tile list
        tiles = []
        
        // Create tiles
        for (index, letter) in anagram1.characters.enumerated(){
            // Check if a character is not a space
            if letter != " " {
               let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + TileMargin), y: ScreenHeight * 0.85)
                tile.randomize()
                tile.dragDelegate = self
                
                // Add the tile to the gameView
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
    }
    
    // Place tiles on slots
    func placeTile(tileView: TileView, slotView: SlotView) {
        
        slotView.isMatches = true
        tileView.isMatches = true
        
        // diable user interaction so player can't move the tile anymore
        tileView.isUserInteractionEnabled = false
        
        // create an animation that will last 35 hundredths os seconds
        UIView.animate(withDuration: 0.35, delay: 0.00, options: UIViewAnimationOptions.curveEaseOut, animations: {
            tileView.center = slotView.center
            // this will undo any tranformations done to the tile i.e rotating, scaling
            tileView.transform = CGAffineTransform.identity
        }) { (value: Bool) in
            slotView.isHidden = true
        }
    }
}

// Add an extension to conform to TileDragDelegateProtocol
extension GameController:TileDragDelegateProtocol {
    // a tile was dragged, check if matches a target
    func tileViewDragged(tileView: TileView, didDragToPoint point: CGPoint) {
        var slotView: SlotView?
        for sv in slots {
            if sv.frame.contains(point) && !sv.isMatches {
                slotView = sv
                break
            }
        }
        // check if target was found
        if let slotView = slotView {
            
            // check if letter matches
            if slotView.letter == tileView.letter {
                // Success
                self.placeTile(tileView: tileView, slotView: slotView)
                
                //more stuff to do on success here
                
                print("Check if the player has completed the phrase")
            } else {
                
                // Failure
                tileView.randomize()
                UIView.animate(withDuration: 0.35, delay: 0.00, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    tileView.center = CGPoint(x: tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20),
                                              y: tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
                }, completion: nil)
                
                //more stuff to do on failure here
            }
        }
    }
}
