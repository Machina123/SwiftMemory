//
//  GameViewController.swift
//  MemoryFind
//
//  Created by Machina on 18.09.2015.
//  Copyright © 2015 Machina. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

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
    
    var gameField : [Int]?
    var shuffledGameField : [AnyObject]?
    
    var cardPairs : CGFloat = 0
    var pairsDiscovered : CGFloat = 0
    var buttonSize: CGSize?
    
    internal var button1Tag : Int = -1
    internal var button2Tag : Int = -1
    
    internal var button1 : UIButton?
    internal var button2 : UIButton?
    
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
        // sender.setTitle(String.init(sender.tag), forState: UIControlState.Normal)
        if button1Tag == -1 {
            button1Tag = sender.tag
            sender.setBackgroundImage(UIImage.init(named: String.init(shuffledGameField![sender.tag - 100])), forState: UIControlState.Normal)
            return
        }
        
        if(button2Tag == -1 && sender.tag != button1Tag) {
            button2Tag = sender.tag
            sender.setBackgroundImage(UIImage.init(named: String.init(shuffledGameField![sender.tag - 100])), forState: UIControlState.Normal)
            if shuffledGameField![button1Tag - 100] === shuffledGameField![button2Tag - 100] {
                print("TO SAMO")
                
                self.button1 = self.view.viewWithTag(button1Tag) as? UIButton

                self.button2 = self.view.viewWithTag(button2Tag) as? UIButton

                let time = dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue(),{
                    self.button1!.enabled = false
                    self.button1!.backgroundColor = UIColor.greenColor()
                    self.button2!.enabled = false
                    self.button2!.backgroundColor = UIColor.greenColor()
                })
                
                ++pairsDiscovered
                
                if(pairsDiscovered == cardPairs) {
                        NSThread.sleepForTimeInterval(1)
                        let alertController = UIAlertController(title: "Wygrana!", message: "Koniec gry, wszystie pary odkryte", preferredStyle: .Alert)
                    let alertActon = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: alertHandler)
                        
                        alertController.addAction(alertActon)
                        
                    self.presentViewController(alertController, animated: true, completion:nil)
                    
                    

                }
            } else {
                    self.button1 = self.view.viewWithTag(button1Tag) as? UIButton
                    self.button2 = self.view.viewWithTag(button2Tag) as? UIButton
                
                let time = dispatch_time(DISPATCH_TIME_NOW, 1 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue(),{
                    self.button1!.setBackgroundImage(UIImage.init(named: "Question"), forState: UIControlState.Normal)
                    self.button2!.setBackgroundImage(UIImage.init(named: "Question"), forState: UIControlState.Normal)
                })
            }
        }
        button1Tag = -1
        button2Tag = -1
    }
    
    func alertHandler(alert: UIAlertAction!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func fillAndShuffleGameField() -> Void {
        gameField = [Int](count: Int.init(cardPairs) * 2, repeatedValue: 0)
        for i in 0..<Int.init(cardPairs) {
            for j in 0..<2 {
                gameField![(2*i)+j] = i
            }
        }
        
        shuffledGameField = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(gameField!)
        
        print(shuffledGameField!)
    }
    
    internal func generateField() -> Void {
        
        let buttonWidth : CGFloat = screenWidth / gameCols
        let buttonHeight: CGFloat = screenHeight / gameRows
        cardPairs = (gameRows * gameCols) / 2
        
        fillAndShuffleGameField()
        
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
                gameBtn.setBackgroundImage(UIImage.init(named: "Question"), forState: UIControlState.Normal)
                gameBtn.tag = 100 + ((j * intGameCols) + i)
                gameBtn.setTitle(" ", forState: .Normal)
                gameBtn.addTarget(self, action: "btnClick:", forControlEvents: .TouchDown)
                
                
                self.view.addSubview(gameBtn)
                // print("Wygenerowano przycisk")  // TYLKO DLA CELÓW DEBUGOWANIA
            }
        }
    }

}