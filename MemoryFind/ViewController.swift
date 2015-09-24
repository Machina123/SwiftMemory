//
//  ViewController.swift
//  MemoryFind
//
//  Created by Machina on 11.09.2015.
//  Copyright © 2015 Machina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedGameDifficulty : GameViewController.Difficulty = .Unselected

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var btnHard: UIButton!
    @IBOutlet weak var btnEasy: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    
    @IBAction func btnEasyClick(sender: UIButton) {
        self.selectedGameDifficulty = .Easy
    }
    
    @IBAction func btnHardClick(sender: UIButton) {
        self.selectedGameDifficulty = .Hard
    }
    
    @IBAction func btnAboutClick(sender: UIButton) {
        let alertController = UIAlertController(title: "O aplikacji", message: "Gra Memory - autor: Patryk Ciepiela", preferredStyle: .Alert)
        let alertActon = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(alertActon)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! GameViewController
        dest.gameDifficulty = self.selectedGameDifficulty
    }

}

