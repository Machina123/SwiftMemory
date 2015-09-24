//
//  GameViewController.swift
//  MemoryFind
//
//  Created by Machina on 18.09.2015.
//  Copyright © 2015 Machina. All rights reserved.
//

import Foundation
import UIKit

class GameViewController : UIViewController {
    
    enum Difficulty : String {
        case Unselected = "Unselected"
        case Easy = "Easy"
        case Hard = "Hard"
    }
    
    var gameDifficulty : Difficulty = .Unselected
    
    let screenWidth : CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight : CGFloat = UIScreen.mainScreen().bounds.height
    
    var gameRows : CGFloat = 0
    var gameCols : CGFloat = 0
    
    var cardPairs : CGFloat = 0
    
    var usedCards: [Int]?
    
    var buttonSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(gameDifficulty.rawValue)
        
        switch(gameDifficulty) {
        case .Easy:
            gameRows = 4
            gameCols = 3
            generateField()
            break
        case .Hard:
            gameRows = 7
            gameCols = 4
            generateField()
            break
        default:
            self.dismissViewControllerAnimated(true, completion: nil)
        }

    }
    
    func btnClick(sender:UIButton!) {
        sender.setTitle(String.init(sender.tag), forState: UIControlState.Normal)
    }
    
    internal func generateField() -> Void {
        
        let buttonWidth : CGFloat = screenWidth / gameCols
        let buttonHeight: CGFloat = screenHeight / gameRows
        cardPairs = (gameRows * gameCols) / 2
        usedCards = [Int](count: Int.init(floor(cardPairs)) + 1, repeatedValue: 0)
        let buttonSize = CGSize(width: buttonWidth, height: buttonHeight)
        
        let intGameRows : Int = Int.init(gameRows)
        let intGameCols : Int = Int.init(gameCols)
        
        for i in 0..<intGameCols{
            for j in 0..<intGameRows {
                let buttonOrigin : CGPoint = CGPoint(x: i * Int.init(buttonWidth), y: j * Int.init(buttonHeight))
                
                let gameBtn : UIButton = UIButton()
                
                let gameBtnRect : CGRect = CGRect(origin: buttonOrigin, size: buttonSize)
                
                gameBtn.frame = gameBtnRect
                gameBtn.layer.borderWidth = 1
                gameBtn.layer.borderColor = UIColor.blackColor().CGColor
                gameBtn.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1.0)
                gameBtn.tag = ((j * intGameCols) + i)
                gameBtn.setTitle(" ", forState: .Normal)
                gameBtn.addTarget(self, action: "btnClick:", forControlEvents: .TouchDown)
                
                
                self.view.addSubview(gameBtn)
                print("Wygenerowano przycisk")
            }
        }
        
    }
    
}